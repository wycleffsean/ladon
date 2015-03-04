module Ladon
  class AuthorizationScope
    def initialize(provider, &block)
      @klass = provider.const_set 'Authorization', Class.new #AccessToken
      instance_eval &block
    end
    def request(&block)
      form = Class.new(BasicObject)
      scope = AttributeReaderScope.new form, &block
      scope.instance_eval &block
      @klass.send :define_method, 'form', &(proc { form.new })
    end
    def url(value)
      block = proc { value }
      @klass.send :define_method, 'url', &block
    end
  end
end
