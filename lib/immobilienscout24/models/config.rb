# Taken from: http://blog.confabulus.com/2008/12/30/making-your-plugin-or-gem-configurable/
module IS24
  
  class Config
    
    attr_writer :oauth_key
    attr_writer :oauth_secret
    attr_writer :oauth_site
    attr_writer :oauth_request_token_path
    attr_writer :oauth_access_token_path
    attr_writer :oauth_authorize_path
    
    def initialize # :nodoc:
      self.oauth_site = 'https://rest.immobilienscout24.de'
      self.oauth_request_token_path = '/restapi/security/oauth/request_token'
      self.oauth_access_token_path = '/restapi/security/oauth/access_token'
      self.oauth_authorize_path = '/restapi/security/oauth/confirm_access'
    end
    
    def api_version
      'v1.0'
    end
    
    def oauth_key #:nodoc:
      @oauth_key
    end
    
    def oauth_secret #:nodoc:
      @oauth_secret
    end
    
    def oauth_site #:nodoc:
      @oauth_site
    end
    
    def oauth_request_token_path #:nodoc:
      @oauth_request_token_path
    end
    
    def oauth_access_token_path #:nodoc:
      @oauth_access_token_path
    end
    
    def oauth_authorize_path #:nodoc:
      @oauth_authorize_path
    end
    
  end
end