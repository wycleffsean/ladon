require 'ladon/scopes/authorization_scope'
require 'ladon/provider'

module Ladon

  class OauthProviderBuilder
    def self.build(name, &block)
      fail 'block must be provided' unless block_given?
      new name, &block
    end
   
    def initialize(provider_name, &block)
      @klass = Ladon.const_set provider_name, Class.new(Provider)
      instance_eval &block
    end
   
    def authorization(&block)
      # configure OauthProvider::Reddit::Authorization
      AuthorizationScope.new(@klass, &block)
    end
   
    def grant(&block)
      # configure OauthProvider::Reddit::Grant
      GrantScope.new(@klass, &block)
    end

    def application_id(value)
      attr_reader 'application_id', value
    end

    def application_secret(value)
      attr_reader 'application_secret', value
    end

    private
    
    def attr_reader(name, value)
      @klass.send :define_method, name, &(proc { value })
    end
  end
   

  class GrantScope
    def initialize(provider, &block)
      @klass = provider.const_set 'Grant', Class.new #AccessToken
      instance_eval &block
    end
  end

  class AttributeReaderScope
    def initialize(klass, &block)
      @klass = klass
      instance_eval &block
    end

    def method_missing(attribute, value)
      block = proc { value }
      @klass.send :define_method, attribute, &block
    end
  end

end
