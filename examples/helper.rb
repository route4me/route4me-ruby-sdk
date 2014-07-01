require 'json'

def addresses
  File.open('./addresses.json', "r") do |f|
    JSON.load(f)
  end
end
