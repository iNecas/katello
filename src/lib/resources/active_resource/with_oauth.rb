module Resources::ActiveResource::WithOauth
  def self.included(base)
    base.send(:extend, ClassMethods)
  end

  module ClassMethods
    def oauth_key
      # Not using superclass_delegating_reader. See +active_resource::Base.site+ for explanation
      if defined?(@oauth_key)
        @oauth_key
      elsif superclass != Object && superclass.oauth_key
        superclass.oauth_key.dup.freeze
      end
    end

    # Sets the oauth key to the value in the +oauth_key+ argument.
    def oauth_key=(oauth_key)
      @connection = nil
      @oauth_key = oauth_key
    end

    def oauth_secret
      # Not using superclass_delegating_reader. See +active_resource::Base.site+ for explanation
      if defined?(@oauth_secret)
        @oauth_secret
      elsif superclass != Object && superclass.oauth_secret
        superclass.oauth_secret.dup.freeze
      end
    end

    # Sets the oauth key to the value in the +oauth_key+ argument.
    def oauth_secret=(oauth_secret)
      @connection = nil
      @oauth_secret = oauth_secret
    end

    def connection(refresh = false)
      if defined?(@connection) || superclass == Object
        unless oauth_configured?
          return super
        end

        @connection = Resources::ActiveResource::OauthConnection.new(site, format) if refresh || @connection.nil?
        @connection.proxy = proxy if proxy
        #@connection.user = user if user
        #@connection.password = password if password
        #@connection.auth_type = auth_type if auth_type
        @connection.timeout = timeout if timeout
        @connection.ssl_options = ssl_options if ssl_options
        @connection.oauth_key = oauth_key
        @connection.oauth_secret = oauth_secret
        @connection
      else
        superclass.connection
      end
    end


    def oauth_configured?
      !!(oauth_key && oauth_secret)
    end
  end

end