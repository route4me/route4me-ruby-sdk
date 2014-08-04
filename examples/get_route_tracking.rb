require 'route4me'

Route4me.api_key = '11111111111111111111111111111111'
route = Route4me::Route.get({
  :route_id => 'AC16E7D338B551013FF34266FE81A5EE',
  :device_tracking_history => true
})

puts route[:tracking_history]
