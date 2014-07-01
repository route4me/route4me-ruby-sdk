require 'route4me'
require './helper'

Route4me.api_key = '11111111111111111111111111111111'
problem = Route4me::OptimizationProblem.optimize(
  :addresses => addresses.first(10),
  :parameters => {
    :algorithm_type          => Route4me::AlgorithmType::TSP,
    :distance_unit           => Route4me::DistanceUnit::MILES,
    :device_type             => Route4me::DeviceType::WEB,
    :optimize                => Route4me::OptimizationType::DISTANCE,
    :travel_mode             => Route4me::TravelMode::DRIVING,
    :vehicle_capacity        => 1,
    :vehicle_max_distance_mi => 10000
  }
)

puts problem
