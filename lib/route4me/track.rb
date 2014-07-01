module Route4me
  class Track
    def self.url
      '/track/set.php'
    end

    def self.set(params={})
      get = Util.extract(params, %i(
        format member_id route_id tx_id vehicle_id course speed
        lat lng altitude device_type device_guid device_timestamp
        app_version
      ))

      response = Route4me.request(:get, self.url, get: get)
      response['status']
    end
  end
end
