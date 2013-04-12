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
      id
    end
    
    def contact_details
      @contact_details ||= Contact.new(info['contactDetails'])
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