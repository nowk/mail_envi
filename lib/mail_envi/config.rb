module MailEnvi
  class Config
    def initialize &block
      @environments = ['development', 'test']

      instance_eval(&block) if block_given?
    end

    attr_accessor :interceptor, :environments, :default_to

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
