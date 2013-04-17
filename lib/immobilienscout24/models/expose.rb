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
    
    def offline?
      response = Net::HTTP.get_response(URI.parse("http://www.immobilienscout24.de/expose/#{id}"))
      case response.code
      when '200'
        return false
      when '302'
        return response['location'].ends_with?('objekt-nicht-gefunden.jsp')
      when '404'
        return true
      end
    end
    
    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def self.by_id(expose_id, token=nil, secret=nil)
      return self.new(IS24::Api.new(token, secret).get("search/#{IS24.config.api_version}/expose/#{expose_id}")['expose.expose'])
    end
    
    def self.contact(expose_id, params)
      # preserve params order!
      request_body = {
        'expose.contactForm' => {
          '@contactFormType' => self.by_id(expose_id).contact_form_type,
          'firstname' => nil,
          'lastname' => nil,
          'phoneNumber' => nil,
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
      }.to_json
      
      response = IS24::Api.new.post("search/#{IS24.config.api_version}/expose/#{expose_id}/contact", request_body)
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