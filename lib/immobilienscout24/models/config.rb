# Taken from: http://blog.confabulus.com/2008/12/30/making-your-plugin-or-gem-configurable/
module IS24
  
  class Config
    
    attr_writer :oauth_key
    attr_writer :oauth_secret
    attr_writer :oauth_site
    attr_writer :oauth_request_token_path
    attr_writer :oauth_access_token_path
    attr_writer :oauth_authorize_path
    attr_writer :enable_logging
    attr_writer :default_search_options
    attr_writer :default_radius_search_options
    attr_writer :default_region_search_options
    attr_writer :always_strict_request
    
    def initialize # :nodoc:
      self.oauth_site = 'https://rest.immobilienscout24.de'
      self.oauth_request_token_path = '/restapi/security/oauth/request_token'
      self.oauth_access_token_path = '/restapi/security/oauth/access_token'
      self.oauth_authorize_path = '/restapi/security/oauth/confirm_access'
      self.enable_logging = false
      self.default_search_options = {}
      self.default_radius_search_options = {}
      self.default_region_search_options = {}
      self.always_strict_request = false
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
    
    def enable_logging
      @enable_logging
    end
    
    def default_search_options
      @default_search_options
    end
    
    def default_radius_search_options
      @default_radius_search_options
    end
    
    def default_region_search_options
      @default_region_search_options
    end

    def always_strict_request
      @always_strict_request
    end
    
  end
end