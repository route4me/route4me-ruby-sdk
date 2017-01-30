require 'cgi'
require 'set'
require 'openssl'
require 'rest_client'
require 'json'

# Enums
require 'route4me/enum/algorithm_type'
require 'route4me/enum/distance_unit'
require 'route4me/enum/device_type'
require 'route4me/enum/optimization_type'
require 'route4me/enum/travel_mode'
require 'route4me/enum/metric'
require 'route4me/enum/direction_method'
require 'route4me/enum/avoid'

# Errors
require 'route4me/errors/route4me_error'
require 'route4me/errors/api_error'

# Version
require 'route4me/version'

# Util
require 'route4me/util'

# Resources
require 'route4me/optimization_problem'
# require 'route4me/address'
require 'route4me/route'
require 'route4me/track'

module Route4me
  class << self
    attr_accessor :api_key, :api_base
  end

  @api_base = 'http://route4me.com'

  def self.api_url(url='')
    @api_base + url
  end

  def self.uri_encode(params)
    params.map{ |k,v| "#{k}=#{Util.url_encode(v)}" }.join('&')
  end

  # codebeat:disable[LOC]
  def self.request(method, url, opts)
    unless @api_key
      raise ArgumentError.new('No API key provided.')
    end

    get = opts[:get] || {}
    json = opts[:json] || {}

    url = api_url(url)
    get[:api_key] = self.api_key
    url += "?#{uri_encode(get)}"

    case method.to_s.downcase.to_sym
    when :post, :put
      payload = json.to_json if json && json.any?
    else
      payload = nil
    end

    request_opts = {
      method: method, open_timeout: 30, url: url,
      timeout: 80, payload: payload
    }

    begin
      response = execute(request_opts)
    rescue SocketError => e
      handle_error(e)
    rescue RestClient::ExceptionWithResponse => e
      if rcode = e.http_code and rbody = e.http_body
        handle_api_error(rcode, rbody)
      else
        handle_error(e)
      end
    rescue RestClient::Exception, Errno::ECONNREFUSED => e
      handle_error(e)
    end

    Util.symbolize_names(parse(response))
  end
  # codebeat:enable[LOC]

  def self.execute(attrs)
    RestClient::Request.execute(attrs)
  end

  def self.parse(response)
    begin
      response = JSON.parse(response.body)
    rescue JSON::ParserError
      response = nil
    end

    response
  end

  def self.handle_error(e)
     raise Route4meError, e.message
  end

  def self.handle_api_error(code, body)
    begin
      error_message = JSON.parse(body)
      error_message = error_message['errors']
    rescue
      raise Route4meError
    end

    raise ApiError, code, error_message
  end
end
