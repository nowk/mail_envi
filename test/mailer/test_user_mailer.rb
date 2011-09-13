require 'test_helper'

require File.expand_path("../../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

class UserMailerTest < ActiveSupport::TestCase # ActionMailer::TestCase
  context "in an included environment" do
    should "be intercepted" do
      mock(user = Object.new)
      stub(user).email {'user@company.com'}

      email = UserMailer.registration_complete(user).deliver
      assert (not ActionMailer::Base.deliveries.empty?)
      assert_equal ['configured@company.com'], email.to
      assert_match /\(#{MailEnvi.ronment} Interception\)/i, email.subject
      # assert_match /hello world/i, email.body
    end
  end
end
