# encoding: UTF-8
module IS24
  class User < Api

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

    def username
      @username ||= @attributes['user.userName']
    end

    def contact_details
      @contact_details ||= Contact.new(@attributes['user.userContactDetails'])
    end

    def company_wide_id
      @company_wide_id ||= @attributes['user.companyWideId']
    end

    def user_state
      @user_state ||= @attributes['user.userState']
    end

    def sso_id
      @sso_id ||= @attributes['user.ssoid']
    end

    def customer_number
      @customer_number ||= @attributes['user.customerNumber']
    end

    def customer_company_wide_id
      @customer_company_wide_id ||= @attributes['user.customerCompanyWideId']
    end

    def internal_test
      @internal_test ||= @attributes['user.internalTest']
    end

    def logo_url
      @logo_url ||= get("offer/#{IS24.config.api_version}/realtor/#{username}/logo")['common.realtorLogo']['realtorLogoUrl']
    end

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def self.query(attribute_name, attribute_value)
      return self.new(IS24::Api.new.get("account/#{IS24.config.api_version}/user?#{attribute_name}=#{attribute_value}")['user.user'])
    end

    def self.by_username(username)
      user_details = IS24::Api.new.get("account/#{IS24.config.api_version}/user/#{username}")
      return unless user_details.present?

      return self.new(IS24::Api.new.get("account/#{IS24.config.api_version}/user/#{username}")['user.user'])
    end

    def self.by_sso_id(value)
      self.query('ssoid', value)
    end

    def self.by_address_id(value)
      self.query('addressid', value)
    end

    def self.by_business_address_id(value)
      self.query('businessaddressid', value)
    end

    def self.by_email(value)
      self.query('email', value)
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