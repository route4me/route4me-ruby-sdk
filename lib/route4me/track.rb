module Route4me
  class Track
    def self.url
      '/track/set.php'
    end

    def self.set(params={})
      get = Util.extract(params, [
        :format, :member_id, :route_id, :tx_id, :vehicle_id, :course,
        :speed, :lat, :lng, :altitude, :device_type, :device_guid,
        :device_timestamp, :app_version
      ])

      Route4me.request(:get, self.url, get: get)[:status]
    end
  end
end
