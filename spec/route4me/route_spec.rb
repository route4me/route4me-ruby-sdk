require File.expand_path('../../spec_helper', __FILE__)

describe Route4me::Route do
  before(:all) do
    problem = Route4me::OptimizationProblem.optimize(
      :parameters => { :disable_optimization => true },
      :addresses  => addresses
    )

    @route_id = problem[:routes][0][:route_id]
  end

  it 'should return route by id' do
    route = Route4me::Route.get(:route_id => @route_id)

    expect(route).not_to be_nil
    expect(route[:route_id]).to eq(@route_id)
    expect(route[:tracking_history]).to be_nil
    expect(route[:optimization_problem_id]).to_not be_empty
  end

  it 'should return route by id with tracking' do
    2.times do 
      Route4me::Track.set(
        :format      => 'json',
        :member_id   => 1,
        :route_id    => @route_id,
        :course      => 1,
        :speed       => 120,
        :lat         => 41.8927521,
        :lng         => -109.0803888,
        :device_type => 'iphone',
        :device_guid => 'qweqweqwe'
      )
    end

    route = Route4me::Route.get(
      :route_id                => @route_id,
      :device_tracking_history => true
    )

    expect(route).not_to be_nil
    expect(route[:route_id]).to eq(@route_id)
    expect(route[:optimization_problem_id]).to_not be_empty
    expect(route[:tracking_history]).to_not be_nil
    expect(route[:tracking_history]).to be_kind_of(Array)
    expect(route[:tracking_history].length).to eq(2)
  end

  it 'should returns 5 routes' do
    routes = Route4me::Route.get(:limit => 5)

    expect(routes).not_to be_nil
    expect(routes.length).to eq(5)
  end

  it 'should remove route by route_id' do
    Route4me::Route.delete(:route_id => @route_id) == true
  end
end
