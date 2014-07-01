require 'route4me'
require 'test/unit'
require 'mocha/setup'
require 'shoulda'

Route4me.api_base='http://staging.route4me.com:8080'
Route4me.api_key="11111111111111111111111111111111"

class Test::Unit::TestCase
  include Mocha
end
