require 'test_helper'
require 'rails'

$:.unshift File.expand_path('../../lib', __FILE__)
require 'mail_envi'

class TestMailEnvi < ActiveSupport::TestCase
  include ActiveSupport::Testing::Isolation

  def mail_envi
    MailEnvi::Rails::RailTie.new
  end

  context "in a production environment" do
    setup { stub(MailEnvi).ronment {'production'} }

    should "not register the Mail interceptor" do
      dont_allow(::Mail).register_interceptor(anything)
      mail_envi.run_initializers
    end
  end

  context "in a development, test or included environments" do
    should "register the default Mail interceptor" do
      MailEnvi.config do |config|
        config.include_environments [:staging, :beta]
      end

      %w(development test staging beta).each do |v|
        stub(MailEnvi).ronment {v}
        mock(::Mail).register_interceptor(MailEnvi::Jealousy)
        mail_envi.run_initializers
      end
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
