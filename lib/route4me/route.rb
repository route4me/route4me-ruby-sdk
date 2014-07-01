module Route4me
  class Route
    def self.url
      '/api.v4/route.php'
    end

    def self.get(params={}, api_key=nil)
      get = Util.extract(params, %i(
        route_id directions route_path_output
        device_tracking_history limit offset
        original
      ))
      Route4me.request(:get, self.url, get: get)
    end
  end
end
