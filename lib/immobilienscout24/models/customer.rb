module IS24
  class Customer < Api
    
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
    
    def contract_contact_details
      @contract_contact_details ||= Contact.new(@attributes['customer.contractContactDetails'])
    end
    
    def differing_billing_contact_details
      @differing_billing_contact_details ||= Contact.new(@attributes['customer.differingBillingContactDetails'])
    end
    
    def billing_details
      @billing_details ||= @attributes['customer.billingDetails']
    end
    
    def customer_number
      @customer_number ||= @attributes['customer.customerNumber']
    end
    
    def commercial
      @commercial ||= @attributes['customer.commercial']
    end
    
    def professional
      @professional ||= @attributes['customer.professional']
    end
    
    def company_wide_id
      @company_wide_id ||= @attributes['customer.companyWideId']
    end
    
    def account_manager
      @account_manager ||= @attributes['customer.accountManager']
    end
    
    def users
      @users ||= @attributes['customer.users']
    end
    
    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def self.query(attribute_name, attribute_value)
      return self.new(IS24::Api.new.get("account/#{IS24.config.api_version}/customer?#{attribute_name}=#{attribute_value}")['customer.customer'])
    end
    
    def self.by_customer_number(customer_number)
      return self.new(IS24::Api.new.get("account/#{IS24.config.api_version}/customer/#{customer_number}")['customer.customer'])
    end
    
    def self.by_realtor_id(value)
      self.query('realtorid', value)
    end
    
    def self.by_customer_id(value)
      self.query('customerid', value)
    end
    
    def self.by_company_wide_id(value)
      self.query('companywideid', value)
    end
    
    def self.by_user_id(value)
      self.query('userid', value)
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
    
    def self.by_bank_account_id(value)
      self.query('bankaccountid', value)
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