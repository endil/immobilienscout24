module IS24
  class Geohierarchy
    
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
    
    def continent_details
      @continent_details ||= @attributes['continent'] if @attributes.present?
    end
    
    def continent_name
      @continent_name ||= continent_details['name'] if continent_details.present?
    end
    
    def continent_geocode_id
      @continent_geocode_id ||= continent_details['fullGeoCodeId'] if continent_details.present?
    end
    
    def country_details
      @country_details ||= @attributes['country'] if @attributes.present?
    end
    
    def country_name
      @country_name ||= country_details['name'] if country_details.present?
    end
    
    def country_geocode_id
      @country_geocode_id ||= country_details['fullGeoCodeId'] if country_details.present?
    end
    
    def region_details
      @region_details ||= @attributes['region'] if @attributes.present?
    end
    
    def region_name
      @region_name ||= region_details['name'] if region_details.present?
    end
    
    def region_geocode_id
      @region_geocode_id ||= region_details['fullGeoCodeId'] if region_details.present?
    end
    
    def city_details
      @city_details ||= @attributes['geoHierarchy']['city'] if @attributes.present?
    end
    
    def city_name
      @city_name ||= city_details['name'] if city_details.present?
    end
    
    def city_geocode_id
      @city_geocode_id ||= city_details['fullGeoCodeId'] if city_details.present?
    end
    
    def quarter_details
      @quarter_details ||= @attributes['geoHierarchy']['quarter'] if @attributes.present?
    end
    
    def quarter_name
      @quarter_name ||= quarter_details['name'] if quarter_details.present?
    end
    
    def quarter_geocode_id
      @quarter_geocode_id ||= quarter_details['fullGeoCodeId'] if quarter_details.present?
    end
    
    def neighbourhood_details
      @neighbourhood_details ||= @attributes['geoHierarchy']['neighbourhood'] if @attributes.present?
    end
    
    def neighbourhood_name
      @neighbourhood_name ||= neighbourhood_details['name'] if neighbourhood_details.present?
    end
    
    def neighbourhood_geocode_id
      @neighbourhood_geocode_id ||= neighbourhood_details['fullGeoCodeId'] if neighbourhood_details.present?
    end
    
    #
    # Class methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    def self.gecode_ids_from_fill_geocode_id
      # continentId+countryId+regionId+cityId+quarterId 
      # (1+276+003+001+014 = 1276003001014).
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