# -*- encoding : utf-8 -*-
module IS24
  class Address

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

    def street
      @street ||= @attributes['street']
    end

    def house_number
      @house_number ||= @attributes['houseNumber']
    end

    def postcode
      @postcode ||= @attributes['postcode']
    end

    def city
      @city ||= @attributes['city']
    end

    def quarter
      @quarter ||= @attributes['quarter']
    end

    def wgs84Coordinate
      @wgs84Coordinate ||= @attributes['wgs84Coordinate']
    end

    def latitude
      @latitude ||= wgs84Coordinate.present? ? wgs84Coordinate['latitude'] : nil
    end

    def longitude
      @longitude ||= wgs84Coordinate.present? ? wgs84Coordinate['longitude'] : nil
    end

    def geocoded?
      latitude.present? && longitude.present?
    end

    def geohierarchy
      @geohierarchy ||= IS24::Geohierarchy.new(@attributes['geoHierarchy'])
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