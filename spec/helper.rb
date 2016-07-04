require 'afterbanks'
require 'rspec'
require 'webmock/rspec'
require 'pry-byebug'

WebMock.disable_net_connect!

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end
