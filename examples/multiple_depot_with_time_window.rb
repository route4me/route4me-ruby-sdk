require 'route4me'
require './helper'

Route4me.api_key = '11111111111111111111111111111111'
problem = Route4me::OptimizationProblem.optimize(
  :addresses => addresses,
  :parameters => {
    :algorithm_type          => Route4me::AlgorithmType::CVRP_TW_SD,
    :distance_unit           => Route4me::DistanceUnit::MILES,
    :device_type             => Route4me::DeviceType::WEB,
    :optimize                => Route4me::OptimizationType::DISTANCE,
    :travel_mode             => Route4me::TravelMode::DRIVING,
    :route_max_duration      => 86400,
    :vehicle_capacity        => 50,
    :vehicle_max_distance_mi => 10000,
    :parts                   => 50
  }
)

puts problem
