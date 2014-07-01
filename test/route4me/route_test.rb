require File.expand_path('../../test_helper', __FILE__)

module Route4me
  class RouteTest < Test::Unit::TestCase
    addresses = [
      {
        :address => "6107 Prospect St, Fredericksburg, VA 22407",
        :is_depot => true,
        :lat => 38.2229881287,
        :lng => -77.5451965332,
        :time_window_start => 39600,
        :time_window_end => 61200
      },
      {
        :address => "6202 Blackstone Blvd, Fredericksburg, VA 22407",
        :is_depot => false,
        :lat => 38.2240219116,
        :lng => -77.5488815308,
        :time_window_start => 32400,
        :time_window_end => 64800
      },
      {
        :address => "10700 Heatherwood Dr, Spotsylvania, VA 22553",
        :is_depot => false,
        :lat => 38.2465057373,
        :lng => -77.5649108887,
        :time_window_start => 14400,
        :time_window_end => 68400
      },
      {
        :address => "10416 Rolling Ridge Dr, Spotsylvania, VA 22553",
        :is_depot => false,
        :lat => 38.2465667725,
        :lng => -77.5721282959,
        :time_window_start => 57600,
        :time_window_end => 68400
      },
      {
        :address => "10609 Mystic Pointe Dr, Fredericksburg, VA 22407",
        :is_depot => false,
        :lat => 38.2513427734,
        :lng => -77.5993652344,
        :time_window_start => 28800,
        :time_window_end => 75600
      }
    ]

    problem = Route4me::OptimizationProblem.optimize(
      :parameters => { :disable_optimization => true },
      :addresses => addresses
    )

    route_id = problem['routes'][0]['route_id']

    should 'return route by id' do
      route = Route4me::Route.get(:route_id => route_id)

      assert route
      assert route['route_id']
      assert_equal route['route_id'], route_id
      assert route['optimization_problem_id']
      assert route['tracking_history'].nil?
    end

    should 'return route by id with tracking' do
      2.times do 
        Route4me::Track.set(
          :format      => 'json',
          :member_id   => 1,
          :route_id    => route_id,
          :course      => 1,
          :speed       => 120,
          :lat         => 41.8927521,
          :lng         => -109.0803888,
          :device_type => 'iphone',
          :device_guid => 'qweqweqwe'
        )
      end

      route = Route4me::Route.get(
        :route_id                => route_id,
        :device_tracking_history => true
      )

      assert route
      assert route['route_id']
      assert_equal route['route_id'], route_id
      assert route['optimization_problem_id']
      assert route['tracking_history'].kind_of? Array
      assert_equal route['tracking_history'].length, 2
    end

    should 'return 5 routes' do
      routes = Route4me::Route.get(:limit => 5)

      assert routes
      assert_equal routes.length, 5
    end
  end
end
