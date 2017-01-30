require 'route4me'
require './helper'

Route4me.api_key = '11111111111111111111111111111111'
problem = Route4me::OptimizationProblem.optimize(
  :addresses => addresses,
  :parameters => {
    :algorithm_type          => Route4me::AlgorithmType::CVRP_TW_MD,
    :distance_unit           => Route4me::DistanceUnit::MILES,
    :device_type             => Route4me::DeviceType::WEB,
    :optimize                => Route4me::OptimizationType::DISTANCE,
    :travel_mode             => Route4me::TravelMode::DRIVING,
    :route_max_duration      => 85700,
    :vehicle_capacity        => 48,
    :vehicle_max_distance_mi => 9999,
    :parts                   => 48
  }
)

puts problem
