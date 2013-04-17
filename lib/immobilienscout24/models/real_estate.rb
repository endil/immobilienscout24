module IS24
  class RealEstate < Api
    
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
    
    def type
      @type ||= "#{@attributes['@xsi.type']}".split(':').last
    end
    
    def title
      @title ||= @attributes['title']
    end
    
    def created_at
      return Time.parse(@attributes['creationDate']).utc if @attributes['creationDate'].present?
      return Time.parse(@attributes['@creationDate']).utc if @attributes['@creationDate'].present?
      return Time.parse(@attributes['@creation']).utc if @attributes['@creation'].present?
    end
    
    def updated_at
      return Time.parse(@attributes['lastModificationDate']).utc if @attributes['lastModificationDate'].present?
      return Time.parse(@attributes['@lastModificationDate']).utc if @attributes['@lastModificationDate'].present?
      return Time.parse(@attributes['@modification']).utc if @attributes['@modification'].present?
    end
    
    def published_at
      @published_at ||= Time.parse(@attributes['@publishDate']).utc if @attributes['@publishDate'].present?
    end
    
    def address
      @address ||= IS24::Address.new(@attributes['address']) if @attributes['address'].present?
    end
    
    def group_number
      @group_number ||= @attributes['group_number']
    end
    
    def description_note
      @description_note ||= @attributes['descriptionNote']
    end
    
    def furnishing_note
      @furnishing_note ||= @attributes['furnishingNote']
    end
    
    def location_note
      @location_note ||= @attributes['locationNote']
    end
    
    def other_note
      @other_note ||= @attributes['otherNote']
    end
    
    def attachments
      attachments = []
      if @attributes['attachments'].present?
        @attributes['attachments'].each do |attachment|
          if attachment['attachment'].kind_of?(Hash)
            attachments << IS24::Attachment.new(attachment['attachment'])
          elsif attachment['attachment'].kind_of?(Array)
            attachment['attachment'].each do |attachment|
              attachments << IS24::Attachment.new(attachment)
            end
          end
        end
      end
      return attachments
    end
    
    def pictures
      @pictures ||= attachments.select {|attachment| attachment.picture?}
    end
    
    def picture_by_scale(scale)
      pictures.select {|picture| picture[:size] == scale}
    end
    
    def videos
      @videos ||= attachments.select {|attachment| attachment.video?}
    end
    
    def pdfs
      @pdfs ||= attachments.select {|attachment| attachment.pdf?}
    end
    
    def title_picture
      @title_picture ||= IS24::Attachment.new(@attributes['titlePicture']) if @attributes['titlePicture'].present?
    end
    
    def state
      @state ||= @attributes['state']
    end
    
    def apartment_type
      @apartment_type ||= @attributes['apartmentType']
    end
    
    def floor
      @floor ||= @attributes['floor']
    end
    
    def lift
      @lift ||= @attributes['lift']
    end
    
    def assisted_living
      @assisted_living ||= @attributes['assistedLiving']
    end
    
    def cellar
      @cellar ||= @attributes['cellar']
    end
    
    def handicapped_accessible
      @handicapped_accessible ||= @attributes['handicappedAccessible']
    end
    
    def number_of_parking_spaces
      @number_of_parking_spaces ||= @attributes['numberOfParkingSpaces']
    end
    
    def condition
      @condition ||= @attributes['condition']
    end
    
    def last_refurbishment
      @last_refurbishment ||= @attributes['lastRefurbishment']
    end
    
    def interior_quality
      @interior_quality ||= @attributes['interiorQuality']
    end
    
    def construction_year
      @construction_year ||= @attributes['constructionYear']
    end
    
    def free_from
      @free_from ||= @attributes['freeFrom']
    end
    
    def heating_type
      @heating_type ||= @attributes['heatingType']
    end
    
    def firing_types
      @firing_types ||= @attributes['firingTypes']
    end
    
    def building_energy_rating_type
      @building_energy_rating_type ||= @attributes['buildingEnergyRatingType']
    end
    
    def energy_consumption_contains_warm_water
      @energy_consumption_contains_warm_water ||= @attributes['energyConsumptionContainsWarmWater']
    end
    
    def number_of_floors
      @number_of_floors ||= @attributes['numberOfFloors']
    end
    
    def usable_floor_space
      @usable_floor_space ||= @attributes['usableFloorSpace']
    end
    
    def number_of_bed_rooms
      @number_of_bed_rooms ||= @attributes['numberOfBedRooms']
    end
    
    def number_of_bath_rooms
      @number_of_bath_rooms ||= @attributes['numberOfBathRooms']
    end
    
    def guest_toilet
      @guest_toilet ||= @attributes['guestToilet']
    end
    
    def parking_space_type
      @parking_space_type ||= @attributes['parkingSpaceType']
    end
    
    def base_rent
      @base_rent ||= @attributes['baseRent']
    end
    
    def total_rent
      @total_rent ||= @attributes['totalRent']
    end
    
    def service_charge
      @service_charge ||= @attributes['serviceCharge']
    end
    
    def deposit
      @deposit ||= @attributes['deposit']
    end
    
    def heating_costs
      @heating_costs ||= @attributes['heatingCosts']
    end
    
    def heating_costs_in_service_charge
      @heating_costs_in_service_charge ||= @attributes['heatingCostsInServiceCharge']
    end
    
    def pets_allowed
      @pets_allowed ||= @attributes['petsAllowed']
    end
    
    def parking_space_price
      @parking_space_price ||= @attributes['parkingSpacePrice']
    end
    
    def living_space
      @living_space ||= @attributes['livingSpace']
    end
    
    def number_of_rooms
      @number_of_rooms ||= @attributes['numberOfRooms']
    end
    
    def energy_performance_certificate
      @energy_performance_certificate ||= @attributes['energyPerformanceCertificate']
    end
    
    def built_in_kitchen
      @built_in_kitchen ||= @attributes['builtInKitchen']
    end
    
    def balcony
      @balcony ||= @attributes['balcony']
    end
    
    def certificate_of_eligibility_needed
      @certificate_of_eligibility_needed ||= @attributes['certificateOfEligibilityNeeded']
    end
    
    def garden
      @garden ||= @attributes['garden']
    end
    
    def floorplan
      @floorplan ||= @attributes['floorplan']
    end
    
    def courtage_details
      @courtage_details ||= @attributes['courtage']
    end
    
    def courtage_has_courtage
      @courtage_has_courtage ||= courtage_details['hasCourtage'] if courtage_details.present?
    end
    
    def courtage
      @courtage ||= courtage_details['courtage'] if courtage_details.present?
    end
    
    def courtage_note
      @courtage_note ||= courtage_details['courtageNote'] if courtage_details.present?
    end
    
    # Price
    def price_details
      @price_details ||= @attributes['price']
    end
    
    def price
      @price ||= price_details['value'] if price_details.present?
    end
    
    def price_currency
      @price_currency ||= price_details['currency'] if price_details.present?
    end
    
    def price_marketing_type
      @price_marketing_type ||= price_details['marketingType'] if price_details.present?
    end
    
    def price_price_interval_type
      @price_price_interval_type ||= price_details['priceIntervalType'] if price_details.present?
    end
    
    # Calculated price
    def calculated_price_details
      @calculated_price_details ||= @attributes['calculatedPrice']
    end
    
    def calculated_price
      @calculated_price ||= calculated_price_details['value'] if calculated_price_details.present?
    end
    
    def calculated_price_currency
      @calculated_price_currency ||= calculated_price_details['currency'] if calculated_price_details.present?
    end
    
    def calculated_price_marketing_type
      @calculated_price_marketing_type ||= calculated_price_details['marketingType'] if calculated_price_details.present?
    end
    
    def calculated_price_price_interval_type
      @calculated_price_price_interval_type ||= calculated_price_details['priceIntervalType'] if calculated_price_details.present?
    end
    
    def calculated_price_rent_scope
      @calculated_price_rent_scope ||= calculated_price_details['rentScope'] if calculated_price_details.present?
    end
    
    # Market value
    def market_value_details
      @market_value_details ||= @attributes['marketValue']
    end
    
    def market_value
      @market_value ||= market_value_details['value'] if market_value_details.present?
    end
    
    def market_value_currency
      @market_value_currency ||= market_value_details['currency'] if market_value_details.present?
    end
    
    def market_value_marketing_type
      @market_value_marketing_type ||= market_value_details['marketingType'] if market_value_details.present?
    end
    
    def market_value_price_interval_type
      @market_value_price_interval_type ||= market_value_details['priceIntervalType'] if market_value_details.present?
    end
    
    def market_value_rent_scope
      @market_value_rent_scope ||= market_value_details['rentScope'] if market_value_details.present?
    end
    
    # Net rent
    def net_rent_details
      @net_rent_details ||= @attributes['marketValue']
    end
    
    def net_rent
      @net_rent ||= net_rent_details['value'] if net_rent_details.present?
    end
    
    def net_rent_currency
      @net_rent_currency ||= net_rent_details['currency'] if net_rent_details.present?
    end
    
    def net_rent_marketing_type
      @net_rent_marketing_type ||= net_rent_details['marketingType'] if net_rent_details.present?
    end
    
    def net_rent_price_interval_type
      @net_rent_price_interval_type ||= net_rent_details['priceIntervalType'] if net_rent_details.present?
    end
    
    def net_rent_rent_scope
      @net_rent_rent_scope ||= net_rent_details['rentScope'] if net_rent_details.present?
    end
    
    # Marketing price
    def marketing_price_details
      @marketing_price_details ||= @attributes['marketingPrice']
    end
    
    def marketing_price
      @marketing_price ||= marketing_price_details['value'] if marketing_price_details.present?
    end
    
    def marketing_price_currency
      @marketing_price_currency ||= marketing_price_details['currency'] if marketing_price_details.present?
    end
    
    def marketing_price_marketing_type
      @marketing_price_marketing_type ||= marketing_price_details['marketingType'] if marketing_price_details.present?
    end
    
    def marketing_price_price_interval_type
      @marketing_price_price_interval_type ||= marketing_price_details['priceIntervalType'] if marketing_price_details.present?
    end
    
    def marketing_price_rent_scope
      @marketing_price_rent_scope ||= marketing_price_details['rentScope'] if marketing_price_details.present?
    end
    
    def visible_price
      case type
      when 'AppartmentRent', 'AppartmentBuy', 'SeniorCare', 'HouseRent', 'HouseBuy', 'SiteLivingBuy', 'SiteLivingRent', 'GarageRent', 'GarageBuy', 'HouseType'
        return price
      when 'SiteTrade', 'Office', 'Gastronomy', 'Investment', 'Industry', 'Store'
        return marketing_price
      when 'FlatShareRoom'
        return net_rent
      when 'AssistedLiving'
        return nil
      when 'CompulsoryAuction'
        return market_value
      end
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