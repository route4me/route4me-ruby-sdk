Route4Me Ruby SDK
-----------------

Access Route4Me's logistics-as-a-service API using our Ruby SDK

## Installation

```
gem install --source https://github.com/route4me/route4me-ruby-sdk route4me
# or
gem install route4me
```

## Usage example

### Single Driver Route Optimization

```ruby
require 'route4me'
require './addresses'

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
```

### Multiple Depot Multiple driver route optimization

```ruby
require 'route4me'
require './addresses'

Route4me.api_key = '11111111111111111111111111111111'
problem = Route4me::OptimizationProblem.optimize(
  :addresses => addresses,
  :parameters => {
    :algorithm_type          => Route4me::AlgorithmType::CVRP_TW_MD,
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
```

### More examples

Please see [examples](examples/) folder for more examples, which are to demonstrate examples of Route & GPS calls and some optimization problems (single driver, round trip, multiple driver, time window, re-optimization).

## Tests

```
rake test
```
