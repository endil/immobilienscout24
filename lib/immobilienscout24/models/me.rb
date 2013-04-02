module IS24
  class Me < Api
    
    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def info
      @info ||= get("search/#{IS24.config.api_version}/searcher/me")['searcher.searcher']
    end
    
    def logo
      @logo ||= get("offer/#{IS24.config.api_version}/realtor/me/logo")['common.realtorLogo']
    end
    
    def logo_url
      @logo_url ||= logo['realtorLogoUrl']
    end
    
    def id
      @id ||= info['@id']
    end
    
    def peid
      @peid ||= info['@peid']
    end
    
    def username
      id
    end
    
    def customer_number
      peid
    end
    
    def contact_details
      @contact_details ||= info['contactDetails']
    end
    
    def salutation
      @salutation ||= contact_details['salutation']
    end
    
    def first_name
      @first_name ||= contact_details['firstname']
    end
    
    def last_name
      @last_name ||= contact_details['lastname']
    end
    
    def address
      @address ||= contact_details['address']
    end
    
    def phone
      @phone ||= contact_details['phoneNumber']
    end
    
    def fax
      @fax ||= contact_details['faxNumber']
    end
    
    def mobile
      @mobile ||= contact_details['cellPhoneNumber']
    end

    def url
      @url ||= contact_details['homepageUrl']
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
      @country_code ||= contact_details['countryCode']
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