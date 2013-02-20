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
      @created_at ||= Time.parse(@attributes['@creation'])
    end
    
    def updated_at
      @updated_at ||= Time.parse(@attributes['@modification'])
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
    
    def self.by_id(token, secret, expose_id)
      return self.new(IS24::Api.new(token, secret).get("search/#{IS24.config.api_version}/expose/#{expose_id}")['expose.expose'])
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