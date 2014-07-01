$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'route4me/version'

spec = Gem::Specification.new do |s|
  s.name = 'route4me'
  s.version = Route4me::VERSION
  s.summary = 'Ruby bindings for the Route4me API'
  s.description = 'Routing Software, Route Planning Software, Delivery Route Planner'
  s.author = 'Igor Skrynkovskyy'
  s.email = 'igor@route4me.com'
  s.homepage = 'http://route4me.com'
  s.license = 'MIT'

  s.add_dependency 'rest-client', '~> 1.4'
  s.add_dependency 'mime-types', '~> 1.25'
  s.add_dependency 'json', '~> 1.8.1'

  s.add_development_dependency 'mocha', '~> 0.13.2'
  s.add_development_dependency 'shoulda', '~> 3.4.0'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'rake'

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
