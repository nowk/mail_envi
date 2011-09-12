require 'test_helper'

class TestMailEnvi < Test::Unit::TestCase
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

  context "in a development environment" do
    setup { stub(MailEnvi).ronment {'development'} }

    should "register the Mail interceptor" do
      mock(::Mail).register_interceptor(MailEnvi::Jealousy)
      mail_envi.run_initializers
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
