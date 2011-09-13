require 'test_helper'

$:.unshift File.expand_path('../../../lib', __FILE__)
require 'mail_envi'

class CustomInterceptor
  def self.delivering_email(msg); msg; end
end

class TestConfig < ActiveSupport::TestCase
  include ActiveSupport::Testing::Isolation

  def mail_envi
    MailEnvi::Rails::Railtie.new
  end

  should "have defaults" do
    config = MailEnvi::Config.new
    assert_equal ['development'], config.environments
    assert_equal MailEnvi::DefaultInterceptor, config.interceptor
    assert_equal 'root@localhost', config.default_to
  end

  should "allow the interceptor to be assigned to a custom class" do
    MailEnvi.config do |config|
      config.interceptor = CustomInterceptor
    end

    assert_equal CustomInterceptor, MailEnvi.config.interceptor
  end

  should "allow additional environments to be included" do
    MailEnvi.config do |config|
      config.include_environments [:test, :staging, 'beta']
    end

    assert_equal ['development', 'test', 'staging', 'beta'], 
      MailEnvi.config.environments
  end

  should "allow the defaults in the default interceptor to be overwritten" do
    MailEnvi.config do |config|
      config.default_to = "another@company.com"
    end

    mock(msg = Object.new)
    stub(msg).subject {"Hello world!"}
    mock(msg).to=("another@company.com")
    mock(msg).subject=(anything)
    MailEnvi::DefaultInterceptor.delivering_email(msg)
  end
end
