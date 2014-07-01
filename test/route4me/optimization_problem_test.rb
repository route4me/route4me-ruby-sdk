require File.expand_path('../../test_helper', __FILE__)

module Route4me
  class OptimizationProblemTest < Test::Unit::TestCase
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

    should "Create simple driver optimization" do
      problem = Route4me::OptimizationProblem.optimize(
        :addresses => addresses,
        :parameters => {
            :algorithm_type          => 1,
            :device_type             => 'web',
            :distance_unit           => 'mi',
            :optimize                => 'Distance',
            :travel_mode             => 'Driving',
            :route_max_duration      => 86400,
            :vehicle_capacity        => 1,
            :vehicle_max_distance_mi => 10000
        }
      )

      assert problem
      assert problem['optimization_problem_id']
      assert_equal problem['state'], 4
      assert_equal problem['addresses'].length, 5
      assert problem['parameters']
      parameters = problem['parameters']
      assert parameters
      assert_equal parameters['algorithm_type'], '1'
      assert_equal parameters['rt'], false
      assert_equal parameters['device_type'], 'web'
      assert_equal parameters['distance_unit'], 'mi'
      assert_equal parameters['optimize'], 'Distance'
      assert_equal parameters['travel_mode'], 'Driving'
      assert_equal parameters['route_max_duration'], 86400
      assert_equal parameters['store_route'], true
      assert_equal parameters['vehicle_capacity'], '1'
      assert_equal parameters['vehicle_max_distance_mi'], '10000'
    end

    should "Create simple driver optimization with round trip" do
      problem = Route4me::OptimizationProblem.optimize(
        :addresses => addresses,
        :parameters => {
            :algorithm_type          => 1,
            :rt                      => true,
            :device_type             => 'web',
            :distance_unit           => 'mi',
            :optimize                => 'Distance',
            :travel_mode             => 'Driving',
            :route_max_duration      => 86400,
            :vehicle_capacity        => 1,
            :vehicle_max_distance_mi => 10000
        }
      )

      assert problem
      assert problem['optimization_problem_id']
      assert_equal problem['addresses'].length, 5
      assert_equal problem['state'], 4
      assert problem['parameters']
      parameters = problem['parameters']
      assert parameters
      assert_equal parameters['algorithm_type'], '1'
      assert_equal parameters['rt'], true
      assert_equal parameters['device_type'], 'web'
      assert_equal parameters['distance_unit'], 'mi'
      assert_equal parameters['optimize'], 'Distance'
      assert_equal parameters['travel_mode'], 'Driving'
      assert_equal parameters['route_max_duration'], 86400
      assert_equal parameters['store_route'], true
      assert_equal parameters['vehicle_capacity'], '1'
      assert_equal parameters['vehicle_max_distance_mi'], '10000'
    end

    should "create multiple driver optimization" do
      problem = Route4me::OptimizationProblem.optimize(
        :addresses => addresses,
        :parameters => {
            :algorithm_type          => 3,
            :metric          => 3,
            :rt => true,
            :device_type             => 'web',
            :distance_unit           => 'mi',
            :optimize                => 'Distance',
            :travel_mode             => 'Driving',
            :route_max_duration      => 86400,
            :vehicle_capacity        => 99,
            :vehicle_max_distance_mi => 10000,
            :preferred_matrix_method => 2
        }
      )

      assert problem
      assert problem['optimization_problem_id']
      assert_equal problem['addresses'].length, 5
      assert_equal problem['state'], 4
      assert problem['parameters']
      parameters = problem['parameters']
      assert parameters
      assert_equal parameters['algorithm_type'], '3'
      assert_equal parameters['rt'], true
      assert_equal parameters['device_type'], 'web'
      assert_equal parameters['distance_unit'], 'mi'
      assert_equal parameters['optimize'], 'Distance'
      assert_equal parameters['travel_mode'], 'Driving'
      assert_equal parameters['route_max_duration'], 86400
      assert_equal parameters['store_route'], true
      assert_equal parameters['vehicle_capacity'], '99'
      assert_equal parameters['vehicle_max_distance_mi'], '10000'
    end

    should "create single driver optimization with time window" do
      problem = Route4me::OptimizationProblem.optimize(
        :addresses => addresses,
        :parameters => {
            :algorithm_type          => 4,
            :rt                      => true,
            :device_type             => 'web',
            :distance_unit           => 'mi',
            :optimize                => 'Distance',
            :travel_mode             => 'Driving',
            :route_max_duration      => 86400,
            :vehicle_capacity        => 99,
            :vehicle_max_distance_mi => 10000
        }
      )

      assert problem
      assert problem['optimization_problem_id']
      assert_equal problem['addresses'].length, 5
      assert_equal problem['state'], 4
      assert problem['parameters']
      parameters = problem['parameters']
      assert parameters
      assert_equal parameters['algorithm_type'], '4'
      assert_equal parameters['device_type'], 'web'
      assert_equal parameters['distance_unit'], 'mi'
      assert_equal parameters['optimize'], 'Distance'
      assert_equal parameters['travel_mode'], 'Driving'
      assert_equal parameters['route_max_duration'], 86400
      assert_equal parameters['store_route'], true
      assert_equal parameters['vehicle_capacity'], '99'
      assert_equal parameters['vehicle_max_distance_mi'], '10000'
    end

    should 'create route without optimization' do
      problem = Route4me::OptimizationProblem.optimize(
        :addresses => addresses,
        :parameters => {
            :algorithm_type       => 1,
            :disable_optimization => true
        }
      )

      assert problem
      assert problem['addresses']
      assert problem['parameters']
      assert_equal problem['parameters']['disable_optimization'], true
    end

    should 'return data about optimization' do
      problem = Route4me::OptimizationProblem.optimize(
        :addresses => addresses,
        :parameters => {
            :algorithm_type       => 1,
            :disable_optimization => true
        }
      )

      problem_id = problem["optimization_problem_id"]

      problem = Route4me::OptimizationProblem.get(
        :optimization_problem_id => problem_id
      )

      assert problem
      assert problem['parameters']
      assert problem['addresses']
      assert_equal problem['addresses'].length, 5
      assert_equal problem['optimization_problem_id'], problem_id
    end

    should 'return data about several optimization object' do
      problem = Route4me::OptimizationProblem.get(
        :state => [4, 5],
        :limit => 5
      )

      assert problem
      assert_equal problem.length, 5
      assert_equal problem.class, Array
    end

    should 'update optimization' do
      problem = Route4me::OptimizationProblem.optimize(
        :parameters => { :disable_optimization => true },
        :addresses => addresses
      )

      assert problem
      assert problem['optimization_problem_id']

      problem_id = problem['optimization_problem_id']
      problem = Route4me::OptimizationProblem.update(
        :optimization_problem_id => problem_id,
        :parameters              => {
          :algorithm_type          => 1,
          :device_type             => 'iphone',
          :distance_unit           => 'mi',
          :optimize                => 'Distance',
          :travel_mode             => 'Driving',
          :route_max_duration      => 86400,
          :vehicle_capacity        => 99,
          :vehicle_max_distance_mi => 10000
        }
      )

      assert problem
      assert_equal problem_id, problem['optimization_problem_id']
      assert problem['parameters']
      parameters = problem['parameters']
      assert_equal parameters['device_type'], 'web'
      assert_equal parameters['optimize'], 'Distance'
      assert_equal parameters['travel_mode'], 'Driving'
    end
  end
end
