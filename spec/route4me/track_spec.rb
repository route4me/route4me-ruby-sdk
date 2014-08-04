require File.expand_path('../../spec_helper', __FILE__)

describe Route4me::Track do
  it "Should track device" do
    status = Route4me::Track.set(
      'format'      => 'json',
      'member_id'   => 1,
      'route_id'    => '0CDA1358186D616AFD39FEB579A64974',
      'course'      => 1,
      'speed'       => 120,
      'lat'         => 41.8927521,
      'lng'         => -109.0803888,
      'device_type' => 'iphone',
      'device_guid' => 'qweqweqwe'
    )

    status == true
  end

  it "Should track device with sym" do
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

    status == true
  end
end
