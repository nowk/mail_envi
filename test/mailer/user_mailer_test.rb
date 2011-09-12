require 'test_helper'

class UserMailerTest < ActiveSupport::TestCase #ActionMailer::TestCase
  context "in a test environment" do
    # TODO test is named 'in a test environment' as 
    # of current, I have not be able to successfully and within reason
    # stub the Rails.env within the initializer process
    should "be intercepted" do
      mock(user = Object.new)
      stub(user).email {'user@company.com'}

      email = UserMailer.registration_complete(user).deliver
      assert (not ActionMailer::Base.deliveries.empty?)
      assert_equal ['root@localhost'], email.to
      assert_equal "(test Interception)", email.subject
      assert_match /hello world/i, email.body
    end
  end
end
