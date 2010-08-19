$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
require 'placebook'
require 'spec'
require 'spec/autorun'

def checkin_hash(attributes = {})
  {
    :id => rand(10000000).to_s
  }.merge(attributes)
end

def checkin_json(attributes = {})
  MultiJson.encode(checkin_hash(attributes))
end

Spec::Runner.configure do |config|
  
end
