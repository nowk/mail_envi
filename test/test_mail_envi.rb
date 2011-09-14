require 'test_helper'

# $:.unshift File.expand_path('../../lib', __FILE__)
# require 'mail_envi'

class TestMailEnvi < ActiveSupport::TestCase
  include ActiveSupport::Testing::Isolation

  def mail_envi
    MailEnvi::Rails::Railtie.new
  end

  context "when running these tests" do
    should "run faster than it does now" do
      skip
    end
  end

  context "in a production environment" do
    setup { stub(MailEnvi).ronment {'production'} }

    should "not register the Mail interceptor" do
      dont_allow(::Mail).register_interceptor(anything)
      # mail_envi.run_initializers
      Dummy::Application.initialize!
    end
  end

  context "in a development or included environments" do
    should "register the default Mail interceptor" do
      mail_envi_config = MailEnvi.config do |config|
        config.include_environments [:test, :staging, :beta]
      end

      stub(MailEnvi).ronment {'staging'}
      stub(MailEnvi).config {mail_envi_config}

      mock(::Mail).register_interceptor(MailEnvi::DefaultInterceptor)
      # mail_envi.run_initializers # does not execute after_initialize
      Dummy::Application.initialize!
    end
  end

  context "self.ronment" do
    should "return the Rails.env" do
      mock(::Rails).env {'foo'}
      assert_equal 'foo', MailEnvi.ronment

      mock(::Rails).env {'bar'}
      assert_equal 'bar', MailEnvi.ronment
    end
  end
end
