require 'test_helper'

# require File.expand_path("../../dummy/config/environment.rb",  __FILE__)

class TestUserMailer < ActionMailer::TestCase
  context "when configured with MailEnvi" do
    should "be intercepted" do
      mock(user = Object.new)
      stub(user).email {'user@company.com'}

      Dummy::Application.initialize!

      email = UserMailer.registration_complete(user).deliver
      assert (not ActionMailer::Base.deliveries.empty?)
      assert_equal ['configured@company.com'], email.to
      assert_nil email.bcc
      assert_nil email.cc
      assert_match /\(#{MailEnvi.ronment} user@company.com\)/i, email.subject
    end
  end
end
