require 'rails'
require 'mail'
require 'mail_envi/config'

module MailEnvi
  module Rails
    class Railtie < ::Rails::Railtie
      config.after_initialize do
        if MailEnvi.config.environments.include?(MailEnvi.ronment.to_s)
          ::Mail.register_interceptor(MailEnvi.config.interceptor)
        end
      end
    end
  end


  def self.ronment
    ::Rails.env
  end

  def self.config
    @@config ||= MailEnvi::Config.instance
  end


  class DefaultInterceptor
    def self.delivering_email(msg)
      msg.subject = "(#{MailEnvi.ronment} #{msg.to.join(", ")}) #{msg.subject}"
      msg.to      = MailEnvi.config.default_to
      msg.bcc     = nil
      msg.cc      = nil
    end
  end
end
