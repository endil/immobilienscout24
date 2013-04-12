module IS24
  class Contact
    
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
    
    def company
      @company ||= @attributes['company']
    end
    
    def salutation
      @salutation ||= @attributes['salutation']
    end
    
    def first_name
      @first_name ||= @attributes['firstname']
    end
    
    def last_name
      @last_name ||= @attributes['lastname']
    end
    
    def address
      @address ||= IS24::Address.new(@attributes['address']) if @attributes['address'].present?
    end

    def country_code
      @country_code ||= @attributes['countryCode']
    end

    def email
      @email ||= @attributes['email']
    end

    def phone_number
      @phone_number ||= @attributes['phoneNumber']
    end
    
    def phone_number_country_code
      @phone_number_country_code ||= @attributes['phoneNumberCountryCode']
    end
    
    def phone_number_area_code
      @phone_number_area_code ||= @attributes['phoneNumberAreaCode']
    end
    
    def phone_number_subscriber
      @phone_number_subscriber ||= @attributes['phoneNumberSubscriber']
    end
    
    def fax_number
      @fax_number ||= @attributes['faxNumber']
    end
    
    def fax_number_country_code
      @fax_number_country_code ||= @attributes['faxNumberCountryCode']
    end
    
    def fax_number_area_code
      @fax_number_area_code ||= @attributes['faxNumberAreaCode']
    end
    
    def fax_number_subscriber
      @fax_number_subscriber ||= @attributes['faxNumberSubscriber']
    end
    
    def cell_phone_number
      @cell_phone_number ||= @attributes['cellPhoneNumber']
    end
    
    def cell_phone_number_country_code
      @cell_phone_number_country_code ||= @attributes['cellPhoneNumberCountryCode']
    end
    
    def cell_phone_number_area_code
      @cell_phone_number_area_code ||= @attributes['cellPhoneNumberAreaCode']
    end
    
    def cell_phone_number_subscriber
      @cell_phone_number_subscriber ||= @attributes['cellPhoneNumberSubscriber']
    end

    def url
      @url ||= @attributes['homepageUrl']
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