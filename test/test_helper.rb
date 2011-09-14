ENV["RAILS_ENV"] = "test"

# load the gem lib/ for the require 'mail_envy'
# $:.unshift File.expand_path('../../lib', __FILE__)

# load the dummy app
# require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require File.expand_path("../dummy/config/application.rb",  __FILE__)


begin
  require 'turn'
rescue LoadError
  # /
end

require 'test/unit'
require 'shoulda'
require 'rr'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end

