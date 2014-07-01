module Route4me
  module Util
    def self.extract(params, keys)
      s = params.select{|k,v| keys.include? k.to_sym }
      Hash[s.map{|k, v| [k.to_sym, v] }]
    end

    def self.url_encode(key)
      URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
    end
  end
end
