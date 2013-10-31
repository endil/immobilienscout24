module IS24
  class Entitlement < Api

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

    def entitlement
      @entitlement ||= @attributes['entitlement']
    end

    def name
      @name ||= entitlement['name']
    end

    def product_permission
      @product_permission ||= (entitlement['productPermission'] == 'true')
    end

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def self.by_username_and_entitlement(username, entitlement)
      return self.new(IS24::Api.new.get("account/#{IS24.config.api_version}/user/#{username}/entitlement/#{entitlement}")['entitlement.userEntitlementResponse'])
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