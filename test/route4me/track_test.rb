require File.expand_path('../../test_helper', __FILE__)

module Route4me
  class TrackTest < Test::Unit::TestCase
    should "Track device with string" do
      status = Route4me::Track.set(
        'format' => 'json',
        'member_id' => 1,
        'route_id' => '0CDA1358186D616AFD39FEB579A64974',
        'course' => 1,
        'speed' => 120,
        'lat' => 41.8927521,
        'lng' => -109.0803888,
        'device_type' => 'iphone',
        'device_guid' => 'qweqweqwe'
      )

      assert_equal status, true
    end

    should "Track device with sym" do
      status = Route4me::Track.set(
        format: 'json',
        member_id: 1,
        route_id: '0CDA1358186D616AFD39FEB579A64974',
        course: 1,
        speed: 120,
        lat: 41.8927521,
        lng: -109.0803888,
        device_type: 'iphone',
        device_guid: 'qweqweqwe'
      )

      assert_equal status, true
    end
  end
end
