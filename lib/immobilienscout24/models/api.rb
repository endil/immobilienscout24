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
      
      if IS24.config.enable_logging
        request_startet_at = Time.now
        Rails.logger.info "IS24::Api.get: Startet at #{request_startet_at.iso8601}"
        
        if IS24.config.oauth_key.present? && IS24.config.oauth_secret.present?
          Rails.logger.info "IS24::Api.get: OAuth headers with consumer_key and consumer_secret"
        else
          Rails.logger.info "IS24::Api.get: OAuth headers without consumer_key and consumer_secret"
        end
        
        if @token.present? && @secret.present?
          Rails.logger.info "IS24::Api.get: OAuth headers with access_token and access_secret"
        else
          Rails.logger.info "IS24::Api.get: OAuth headers without access_token or access_secret"
        end
        
        Rails.logger.info "IS24::Api.get: Header: #{headers(options)}"
        Rails.logger.info "IS24::Api.get: Requested: #{IS24.config.oauth_site}/restapi/api/#{url}"
      end
      
      decoded_response = decode(access_token.get("/restapi/api/#{url}", headers(options)))
      
      if IS24.config.enable_logging
        request_finished_at = Time.now
        Rails.logger.info "IS24::Api.get: Finished at #{request_finished_at.iso8601} in #{((request_finished_at - request_startet_at) * 1000).to_i} milliseconds\n\n"
      end
      
      return decoded_response
    end
    
    def get_pages(url, options={})
      results = Array.new
      response = get(url, options)

      if response['common.strictList'].present?
        results << response['common.strictList']['strictEntry'] if response['common.strictList']['strictEntry'].present?

        if response['common.strictList']['paging']['pageNumber'] < response['common.strictList']['paging']['numberOfPages'] &&
            response['common.strictList'].present? && response['common.strictList']['paging'].present? &&
            response['common.strictList']['paging']['next'].present? && response['common.strictList']['paging']['next']['@xlink.href'].present?
          results.concat(get_pages(response['common.strictList']['paging']['next']['@xlink.href'], options))
        end
      else
        
        number_of_hits = response['resultlist.resultlist']['resultlistEntries'].first['@numberOfHits'].to_i
        if number_of_hits > 1
          results.concat(response['resultlist.resultlist']['resultlistEntries'].first['resultlistEntry'])
        elsif number_of_hits == 1
          results << response['resultlist.resultlist']['resultlistEntries'].first['resultlistEntry']
        end

        if response['resultlist.resultlist']['paging']['pageNumber'] < response['resultlist.resultlist']['paging']['numberOfPages'] &&
            response['resultlist.resultlist'].present? && response['resultlist.resultlist']['paging'].present? &&
            response['resultlist.resultlist']['paging']['next'].present? && response['resultlist.resultlist']['paging']['next']['@xlink.href'].present?
          results.concat(get_pages(response['resultlist.resultlist']['paging']['next']['@xlink.href'], options))
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