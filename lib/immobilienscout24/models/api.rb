module IS24
  class Api

    #
    # Authentication
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
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
    
    #
    # Requests
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def headers(options={})
      { 'Accept' => 'application/json' }.merge(options)
    end
    
    def get(url, options={})
      url.gsub!('http://rest.immobilienscout24.de/restapi/api/','')
      url.gsub!('https://rest.immobilienscout24.de/restapi/api/','')

      Rails.logger.info '##################################'
      Rails.logger.info "URL: https://rest.immobilienscout24.de/restapi/api/#{url}\nOptions: #{options.to_query}"
      Rails.logger.info '##################################'
      
      decode(access_token.get("/restapi/api/#{url}", headers(options)))
    end
    
    def get_pages(url, options={})
      results = Array.new
      response = get(url, options)

      if response['common.strictList'].present?
        results << response['common.strictList']['strictEntry'] if response['common.strictList']['strictEntry'].present?

        if response['common.strictList']['paging']['pageNumber'] < response['common.strictList']['paging']['numberOfPages'] &&
            response['common.strictList'].present? && response['common.strictList']['paging'].present? &&
            response['common.strictList']['paging']['next'].present? && response['common.strictList']['paging']['next']['@xlink.href'].present?
          results.concat(get_pages(response['common.strictList']['paging']['next']['@xlink.href'], options, response_object_type))
        end
      else
        results << response['resultlist.resultlist']['resultlistEntries'].first['resultlistEntry'] if response['resultlist.resultlist']['resultlistEntries'].first['resultlistEntry'].present?

        if response['resultlist.resultlist']['paging']['pageNumber'] < response['resultlist.resultlist']['paging']['numberOfPages'] &&
            response['resultlist.resultlist'].present? && response['resultlist.resultlist']['paging'].present? &&
            response['resultlist.resultlist']['paging']['next'].present? && response['resultlist.resultlist']['paging']['next']['@xlink.href'].present?
          results.concat(get_pages(response['resultlist.resultlist']['paging']['next']['@xlink.href'], options, response_object_type))
        end
      end
      return results
    end
    
    def decode(response)
      if response.is_a?(Net::HTTPClientError)
        error = MultiJson.decode(response.body)['common.messages'].first
        raise("IS24::Exception::#{IS24::Exception.translate_into_class_name(error['message']['messageCode'])}".safe_constantize, error['message']['message'])
      end

      if response.body =~ /../
        MultiJson.decode(response.body)
      end
    end
    
  end
end