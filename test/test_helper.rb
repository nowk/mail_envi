# Configure Rails Env
ENV["RAILS_ENV"] = "test"

# load the gem lib/ for the require 'mail_envy'
# $:.unshift File.expand_path('../../lib', __FILE__)

# require File.expand_path("../dummy/config/environment.rb",  __FILE__)
# require "rails/test_help"

begin
  require 'turn'
rescue LoadError
  # noop
end

require 'test/unit'
require 'shoulda'
require 'rr'

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end

def parse(constant)
  source, _, constant_name = constant.to_s.rpartition('::')

  [source.constantize, constant_name]
end

def with_constants(constants, &block)
  saved_constants = {}
  constants.each do |constant, val|
    source_object, const_name = parse(constant)

    saved_constants[constant] = source_object.const_get(const_name)
    Kernel::silence_warnings { source_object.const_set(const_name, val) }
  end

  begin
    block.call
  ensure
    constants.each do |constant, val|
      source_object, const_name = parse(constant)

      Kernel::silence_warnings { source_object.const_set(const_name, saved_constants[constant]) }
    end
  end
end

