module IS24
  class Api

    #### AUTHENTICATION
    
    def initialize(token=nil, secret=nil)
      @token = token
      @secret = secret
    end
  
    def consumer
      @consumer ||= ::OAuth::Consumer.new(IS24.config.oauth_key, IS24.config.oauth_secret, {
        :site => IS24.config.oauth_site,
        :request_token_path => IS24.config.oauth_request_token_path,
        :access_token_path => IS24.config.oauth_access_token_path,
        :authorize_path => IS24.config.oauth_authorize_path
      })
    end

    def access_token
      @access_token ||= ::OAuth::AccessToken.new(consumer, @token, @secret)
    end
    
    #### REQUEST
    
    def headers(options={})
      { 'Accept' => 'application/json' }.merge(options)
    end
    
    def get(url, options={})
      decode(access_token.get("/restapi/api/#{url}", headers(options)))
    end
    
    def decode(response)
      if response.is_a?(Net::HTTPClientError)
        error = MultiJson.decode(response.body)['common.messages'].first
        raise("IS24::Errors::#{IS24::Errors.translate_into_class_name(error['message']['messageCode'])}".safe_constantize, error['message']['message'])
      end

      if response.body =~ /../
        MultiJson.decode(response.body)
      end
    end
    
  end
end