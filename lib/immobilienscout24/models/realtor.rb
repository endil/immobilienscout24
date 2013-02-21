module IS24
  class Realtor
    
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
    
    def company
      @company ||= contact_details['company']
    end
    
    def salutation
      @salutation ||= @attributes['salutation']
    end
    
    def firstname
      @firstname ||= @attributes['firstname']
    end
    
    def lastname
      @lastname ||= @attributes['lastname']
    end
    
    def phone
      @fax ||= contact_details['phoneNumber']
    end

    def fax
      @fax ||= @attributes['faxNumber']
    end
    
    def mobile
      @mobile ||= @attributes['cellPhoneNumber']
    end
    
    def url
      @url ||= contact_details['homepageUrl']
    end
    
    def address
      @address ||= @attributes['address']
    end
    
    def street
      @street ||= address['street']
    end
    
    def house_number
      @house_number ||= address['houseNumber']
    end
    
    def postcode
      @postcode ||= address['postcode']
    end
    
    def city
      @city ||= address['city']
    end
    
    def country_code
      @country_code ||= address['countryCode']
    end
    
    def logo_url
      @logo_url ||= address['realtorLogo']
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