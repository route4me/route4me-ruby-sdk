module Route4me
  module Util
    def self.extract(params, keys)
      s = params.select{|k,v| keys.include? k.to_sym }
      Hash[s.map{|k, v| [k.to_sym, v] }]
    end

    def self.url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end

    def self.symbolize_names(object)
      case object
      when Hash
        new = {}
        object.each do |key, value|
          key = (key.to_sym rescue key) || key
          new[key] = symbolize_names(value)
        end
        new
      when Array
        object.map { |value| symbolize_names(value) }
      else
        object
      end
    end
  end
end
