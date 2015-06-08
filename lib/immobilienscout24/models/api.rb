# -*- encoding : utf-8 -*-
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
      consumer.http.set_debug_output($stdout) if IS24.config.enable_debugging
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

    def post(url, request_body)
      if IS24.config.enable_logging
        request_startet_at = Time.now
        Rails.logger.info "IS24::Api.post: Startet at #{request_startet_at.iso8601}"

        Rails.logger.info "IS24::Api.post: Body: #{request_body}"
        Rails.logger.info "IS24::Api.post: Requested: #{IS24.config.oauth_site}/restapi/api/#{url}"
      end

      response = access_token.post(URI.escape("/restapi/api/#{url}", ' '), request_body, headers({ 'Content-Type' => 'application/json' }))

      if IS24.config.enable_logging
        request_finished_at = Time.now
        Rails.logger.info "IS24::Api.post: Finished at #{request_finished_at.iso8601} in #{((request_finished_at - request_startet_at) * 1000).to_i} milliseconds\n\n"
      end

      return response
    end

    def get(url, options={})
      decoded_response = decode(get_request(url, options={}))
      return decoded_response
    end

    def get_request(url, options={})
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

      response = access_token.get(URI.escape("/restapi/api/#{url}", ' '), headers(options))

      if IS24.config.enable_logging
        request_finished_at = Time.now
        Rails.logger.info "IS24::Api.get: Response body: #{response.body}"
        Rails.logger.info "IS24::Api.get: Finished at #{request_finished_at.iso8601} in #{((request_finished_at - request_startet_at) * 1000).to_i} milliseconds\n\n"
      end

      return response
    end

    def get_pages(url, options={})
      results = Array.new
      begin
        response = get(url, options)
      rescue IS24::Exception::CommonResourceNotFound
      end

      return results if response.nil? || response == ''

      if response['common.strictList'].present?
        results << response['common.strictList']['strictEntry'] if response['common.strictList']['strictEntry'].present?

        if response['common.strictList']['paging']['pageNumber'].to_i < response['common.strictList']['paging']['numberOfPages'].to_i &&
            response['common.strictList']['paging'].present? && response['common.strictList']['paging']['next'].present? &&
            response['common.strictList']['paging']['next']['@xlink.href'].present?
          results.concat(get_pages(response['common.strictList']['paging']['next']['@xlink.href'], options))
        end
      elsif response['resultlist.resultlist'].present?

        number_of_hits = response['resultlist.resultlist']['resultlistEntries'].first['@numberOfHits'].to_i
        request_results = response['resultlist.resultlist']['resultlistEntries'].first['resultlistEntry']
        if number_of_hits > 1 && request_results.kind_of?(Array)
          results.concat(request_results)
        elsif number_of_hits == 1
          results << request_results
        end

        if response['resultlist.resultlist']['paging']['pageNumber'].to_i < response['resultlist.resultlist']['paging']['numberOfPages'].to_i &&
            response['resultlist.resultlist']['paging'].present? && response['resultlist.resultlist']['paging']['next'].present? &&
            response['resultlist.resultlist']['paging']['next']['@xlink.href'].present?
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