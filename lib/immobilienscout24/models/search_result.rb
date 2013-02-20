module IS24
  class SearchResult
    
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
    
    def strict?
      @strict ||= @attributes['@realEstateId'].present?
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
    
    # only in 'normal' results
    def real_estate_id
      @real_estate_id ||= @attributes['@realEstateId']
    end
    
    # only in 'normal' results
    def distance
      @distance ||= @attributes['distance']
    end
    
    # only in 'normal' results
    def real_estate
      @real_estate ||= IS24::RealEstate.new(@attributes['resultlist.realEstate']) if @attributes.class.name == 'Hash'
    end
    
    # only in 'strict' results
    def label
      @label ||= @attributes['@label']
    end
    
    # only in 'strict' results
    def precise_house_number
      @precise_house_number ||= @attributes['preciseHouseNumber']
    end
    
    # only in 'strict' results
    def latitude
      @latitude ||= @attributes['wgs84Coordinate']['latitude'] if @attributes['wgs84Coordinate'].present?
    end
    
    # only in 'strict' results
    def longitude
      @longitude ||= @attributes['wgs84Coordinate']['longitude'] if @attributes['wgs84Coordinate'].present?
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