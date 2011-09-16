module MailEnvi
  class Config
    class << self
      attr_accessor :instance

      def set(&block)
        @instance = new(&block)
      end
    end

    def initialize &block
      @environments = ['development']

      instance_eval(&block) if block_given?
    end

    attr_writer :interceptor, :default_to
    attr_reader :environments

    def interceptor
      @interceptor || MailEnvi::DefaultInterceptor
    end

    def include_environments(envs = [])
      @environments+= envs.map(&:to_s) if envs && envs.any?
    end

    def default_to
      @default_to || 'root@localhost'
    end
  end
end
