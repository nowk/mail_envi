require 'mail'

module MailEnvi
  module Rails
    class RailTie < ::Rails::Railtie
      initializer "mail_envi.register_interceptor" do
        ::Mail.register_interceptor(MailEnvi::Jealousy) unless %w(production).include? MailEnvi.ronment.to_s
      end
    end
  end


  def self.ronment
    ::Rails.env
  end


  class Jealousy
    DEFAULT_TO      = 'root@localhost'
    DEFAULT_SUBJECT = "(#{MailEnvi.ronment} Interception)"

    def self.delivering_email(msg)
      msg.subject = DEFAULT_SUBJECT
      msg.to      = DEFAULT_TO
    end
  end
end
