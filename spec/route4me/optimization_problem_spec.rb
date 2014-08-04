require File.expand_path('../../spec_helper', __FILE__)

describe Route4me::OptimizationProblem do
  it "Should create simple driver optimization" do
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

    expect(problem).not_to be_nil
    expect(problem['optimization_problem_id']).to_not be_empty
    expect(problem['parameters']).to_not be_empty
    expect(problem['addresses'].length).to eq(5)
    expect(problem['state']).to eq(4)

    parameters = problem['parameters']
    expect(parameters['algorithm_type']).to eq("1")
    expect(parameters['rt']).to eq(false)
    expect(parameters['device_type']).to eq('web')
    expect(parameters['distance_unit']).to eq('mi')
    expect(parameters['optimize']).to eq('Distance')
    expect(parameters['travel_mode']).to eq('Driving')
    expect(parameters['route_max_duration']).to eq(86400)
    expect(parameters['vehicle_capacity']).to eq("1")
    expect(parameters['vehicle_max_distance_mi']).to eq("10000")
  end

  it "Should create simple driver optimization with round trip" do
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

    expect(problem).not_to be_nil
    expect(problem['optimization_problem_id']).to_not be_empty
    expect(problem['parameters']).to_not be_empty
    expect(problem['addresses'].length).to eq(5)
    expect(problem['state']).to eq(4)

    parameters = problem['parameters']
    expect(parameters['algorithm_type']).to eq("1")
    expect(parameters['rt']).to eq(true)
    expect(parameters['device_type']).to eq('web')
    expect(parameters['distance_unit']).to eq('mi')
    expect(parameters['optimize']).to eq('Distance')
    expect(parameters['travel_mode']).to eq('Driving')
    expect(parameters['route_max_duration']).to eq(86400)
    expect(parameters['vehicle_capacity']).to eq("1")
    expect(parameters['vehicle_max_distance_mi']).to eq("10000")
  end

  it "Should create multiple driver optimization" do
    problem = Route4me::OptimizationProblem.optimize(
      :addresses => addresses,
      :parameters => {
        :algorithm_type          => 3,
        :metric                  => 3,
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

    expect(problem).not_to be_nil
    expect(problem['optimization_problem_id']).to_not be_empty
    expect(problem['parameters']).to_not be_empty
    expect(problem['addresses'].length).to eq(5)
    expect(problem['state']).to eq(4)

    parameters = problem['parameters']
    expect(parameters['algorithm_type']).to eq("3")
    expect(parameters['device_type']).to eq('web')
    expect(parameters['distance_unit']).to eq('mi')
    expect(parameters['optimize']).to eq('Distance')
    expect(parameters['travel_mode']).to eq('Driving')
    expect(parameters['route_max_duration']).to eq(86400)
    expect(parameters['vehicle_capacity']).to eq('99')
    expect(parameters['vehicle_max_distance_mi']).to eq('10000')
  end

  it "Should create single driver optimization with time window" do
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

    expect(problem).not_to be_nil
    expect(problem['optimization_problem_id']).to_not be_empty
    expect(problem['parameters']).to_not be_empty
    expect(problem['addresses'].length).to eq(5)
    expect(problem['state']).to eq(4)

    parameters = problem['parameters']
    expect(parameters['algorithm_type']).to eq("4")
    expect(parameters['device_type']).to eq('web')
    expect(parameters['distance_unit']).to eq('mi')
    expect(parameters['optimize']).to eq('Distance')
    expect(parameters['travel_mode']).to eq('Driving')
    expect(parameters['route_max_duration']).to eq(86400)
    expect(parameters['vehicle_capacity']).to eq('99')
    expect(parameters['vehicle_max_distance_mi']).to eq('10000')
  end

  it 'Should create route without optimization' do
    problem = Route4me::OptimizationProblem.optimize(
      :addresses => addresses,
      :parameters => {
        :algorithm_type       => 1,
        :disable_optimization => true
      }
    )

    expect(problem).not_to be_nil
    expect(problem['optimization_problem_id']).to_not be_empty
    expect(problem['addresses'].length).to eq(5)
    expect(problem['parameters']).to_not be_empty
    expect(problem['parameters']['disable_optimization']).to eq(true)
  end

  it 'Should return data about optimization' do
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

    expect(problem).not_to be_nil
    expect(problem['addresses'].length).to eq(5)
    expect(problem['parameters']).to_not be_empty
    expect(problem['optimization_problem_id']).to eq(problem_id)
  end

  it 'Should return data about several optimization object' do
    problem = Route4me::OptimizationProblem.get(
      :state => [4, 5],
      :limit => 5
    )

    expect(problem).not_to be_nil
    expect(problem.length).to eq(5)
    expect(problem).to be_kind_of(Array)
  end

  # should 'update optimization' do
  #   problem = Route4me::OptimizationProblem.optimize(
  #     :parameters => { :disable_optimization => true },
  #     :addresses => addresses
  #   )
  #
  #   assert problem
  #   assert problem['optimization_problem_id']
  #
  #   problem_id = problem['optimization_problem_id']
  #   problem = Route4me::OptimizationProblem.update(
  #     :optimization_problem_id => problem_id,
  #     :parameters              => {
  #       :algorithm_type          => 1,
  #       :device_type             => 'iphone',
  #       :distance_unit           => 'mi',
  #       :optimize                => 'Distance',
  #       :travel_mode             => 'Driving',
  #       :route_max_duration      => 86400,
  #       :vehicle_capacity        => 99,
  #       :vehicle_max_distance_mi => 10000
  #     }
  #   )
  #
  #   assert problem
  #   assert_equal problem_id, problem['optimization_problem_id']
  #   assert problem['parameters']
  #   parameters = problem['parameters']
  #   assert_equal parameters['device_type'], 'web'
  #   assert_equal parameters['optimize'], 'Distance'
  #   assert_equal parameters['travel_mode'], 'Driving'
  # end
end
