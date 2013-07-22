module IS24
  class Expose < Api

    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def initialize(attributes={})
      @attributes = attributes
    end
    
    def attributes
      @attributes
    end

    def id
      @id ||= @attributes['@id']
    end
    
    def created_at
      @created_at ||= Time.parse(@attributes['@creation']).utc
    end
    
    def updated_at
      @updated_at ||= Time.parse(@attributes['@modification']).utc
    end
    
    def href
      @href ||= @attributes['@xlink.href']
    end
    
    def imprint_href
      @imprint_href ||= @attributes['imprintLink']['@xlink.href']
    end
    
    def contact_form_type
      @contact_form_type ||= @attributes['@contactFormType']
    end

    def real_estate
      @real_estate ||= IS24::RealEstate.new(@attributes['realEstate'])
    end

    def realtor
      @realtor ||= IS24::Realtor.new(@attributes['contactDetails'])
    end
    
    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def self.offline?(id)
      begin
        response = IS24::Api.new.get_request("search/#{IS24.config.api_version}/expose/#{id}", { 'If-None-Match' => '' })
        case response.code
        when '200', '304'
          return false
        when '404'
          return true
        end
      rescue IS24::Exception::ResourceNotFound
        return true
      end
    end
    
    def self.modified?(id, etag=nil)
      begin
        response = IS24::Api.new.get_request("search/#{IS24.config.api_version}/expose/#{id}", { 'If-None-Match' => "#{etag}" })
        return false if response.body.nil? || response.body == ""

        case response.code
        when '200' # modified
          return { :expose => IS24::Expose.new(IS24::Api.new.decode(response)['expose.expose']), :etag => response.header['etag'].gsub("\"", '') }
        when '304' # not modified
          return false
        when '404' # not found
          return nil
        end
      rescue IS24::Exception::ResourceNotFound
        return nil
      end
    end
    
    def self.by_id(expose_id, token=nil, secret=nil)
      response = IS24::Api.new(token, secret).get("search/#{IS24.config.api_version}/expose/#{expose_id}")
      if response.present?
        return self.new(response['expose.expose'])
      else
        return nil
      end
    end
    
    def self.contact(expose_id, contact_form_type, params)
      # preserve params order!
      request_body = {
        'expose.contactForm' => {
          '@contactFormType' => contact_form_type,
          'firstname' => nil,
          'lastname' => nil,
          'phoneNumber' => nil,
          'emailAddress' => nil,
          'appointmentRequested' => nil,
          'message' => nil,
          'address' => {
            '@xsi.type' => 'common:Address',
            'street' => nil,
            'houseNumber' => nil,
            'postcode' => nil,
            'city' => nil
          }
        }.merge(params)
      }
      
      request_body['expose.contactForm']['address'].delete_if { |k, v| v.nil? }
      request_body['expose.contactForm']['address'] = nil if request_body['expose.contactForm']['address'].empty?
      request_body['expose.contactForm'].delete_if { |k, v| v.nil? }
      
      response = IS24::Api.new.post("search/#{IS24.config.api_version}/expose/#{expose_id}/contact", request_body.to_json)
      return response.code != '200' ? response : true
    end
    
    #
    # Protected
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    # 

    protected

    #
    # Private
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    # 

    private

  end
end