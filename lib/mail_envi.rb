require 'mail'
require 'mail_envi/config'

module MailEnvi
  @config = nil

  module Rails
    class RailTie < ::Rails::Railtie
      initializer "mail_envi.register_interceptor" do
        if MailEnvi.config.environments.include?(MailEnvi.ronment.to_s)
          ::Mail.register_interceptor(MailEnvi.config.interceptor)
        end
      end
    end
  end


  def self.ronment
    ::Rails.env
  end

  def self.config &block
    if block_given?
      @config = MailEnvi::Config.new &block
    else
      @config ||= MailEnvi::Config.new
    end
  end

  def self.reset!
    @config = nil
  end


  class Jealousy
    def self.delivering_email(msg)
      msg.to      = MailEnvi.config.default_to
      msg.subject = "(#{MailEnvi.ronment} Interception) #{msg.subject}"
    end
  end
end
