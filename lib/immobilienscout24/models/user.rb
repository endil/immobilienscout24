module IS24
  class User < Api
    
    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def info
      realtor = IS24::Realtor.new(@token, @secret)
      @info ||= get("account/#{IS24.config.api_version}/user?ssoid=#{realtor.peid}")['user.users'].first['user.user']
    end
    
    def logo
      @logo ||= get("offer/#{IS24.config.api_version}/realtor/#{username}/logo")['common.realtorLogo']
    end
    
    def logo_url
      @logo_url ||= logo['realtorLogoUrl']
    end
    
    def id
      @id ||= info['user.ssoid']
    end
    
    def customer_number
      @customer_number ||= info['user.customerNumber']
    end
    
    def user_details
      @user_details ||= info['user.user']
    end

    def username
      @username ||= info['user.userName']
    end
    
    def contact_details
      @contact_details ||= info['user.userContactDetails']
    end
    
    def company
      @company ||= contact_details['company']
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
    
    def email
      @email ||= contact_details['email']
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