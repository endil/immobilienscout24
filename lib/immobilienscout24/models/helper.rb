module IS24
  class Helper
    
    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    # http://rest.immobilienscout24.de/restapi/api/gis/v1.0/?_wadl&_schema&_file=classpath:/de/is24/common/webservice/xml/common-1.0.xsd
    REAL_ESTATE_TYPES = {
      'APARTMENT_RENT' => 'Mietwohnung',
      'APARTMENT_BUY' => 'Wohnung zum Kauf',
      'HOUSE_RENT' => 'Haus zur Miete',
      'HOUSE_BUY' => 'Haus zum Kauf',
      'GARAGE_RENT' => 'Garage zur Miete',
      'GARAGE_BUY' => 'Garage zum Kauf',
      'LIVING_RENT_SITE' => 'Wohngrundstueck zur Miete',
      'LIVING_BUY_SITE' => 'Wohngrundstueck zum Kauf',
      'TRADE_SITE' => 'Gewerbegrundstueck',
      'HOUSE_TYPE' => 'Typenhaus',
      'FLAT_SHARE_ROOM' => 'WG-Zimmer',
      'SENIOR_CARE' => 'Altenpflege',
      'ASSISTED_LIVING' => 'Seniorenwohnen',
      'OFFICE' => 'Buero und Praxis',
      'INDUSTRY' => 'Halle und Produktion',
      'STORE' => 'Einzelhandel',
      'GASTRONOMY' => 'Gastronomie und Hotel',
      'SPECIAL_PURPOSE' => 'Spezialgewerbe',
      'INVESTMENT' => 'Anlageimmobilie',
      'COMPULSORY_AUCTION' => 'Zwangsversteigerung',
      'SHORT_TERM_ACCOMMODATION' => 'Wohnen auf Zeit (WAZ)'
    }
    
    # RealEstateState
    
    # IS24 API doesn't like: YYYY-MM-DDTHH:MM:SSZ
    def self.iso8601(time)
      time.utc.strftime("%Y-%m-%dT%H:%M:%S")
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