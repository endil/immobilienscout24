# -*- encoding : utf-8 -*-
module IS24
  class Search < Api

    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def radius(*args)
      options = IS24.config.default_radius_search_options.merge(args.extract_options!)
      query(:radius, options)
    end

    # real_estate_type always required
    def in_radius(latitude, longitude, radius, *args)
      options = IS24.config.default_radius_search_options.merge(args.extract_options!)
      query(:radius, options.merge({ geocoordinates: [latitude, longitude, radius].join(';') }))
    end

    def region(*args)
      options = IS24.config.default_region_search_options.merge(args.extract_options!)
      query(:region, options)
    end

    # real_estate_type always required
    def in_region(geocodes, *args)
      options = IS24.config.default_region_search_options.merge(args.extract_options!)
      query(:region, options.merge({ geocodes: geocodes }))
    end

    def near(object, radius, *args)
      latitude = 0
      longitude = 0

      latitude = object.lat if object.respond_to?(:lat)
      latitude = object.latitude if object.respond_to?(:latitude)
      longitude = object.lng if object.respond_to?(:lng)
      longitude = object.longitude if object.respond_to?(:longitude)

      in_radius(latitude, longitude, radius, args.extract_options!)
    end

    def query(search_type, *args)
      options = IS24.config.default_search_options.merge(args.extract_options!)

      base_url = "search/#{IS24.config.api_version}/search"
      if search_type.present? && %w(radius region).include?(search_type.to_s)
        base_url = "#{base_url}/#{search_type}"
      end

      headers = IS24.config.always_strict_request ? { 'Accept' => 'application/json;strict=true' } : {}
      return get_pages("#{base_url}?#{options.to_query}", headers).collect { |result| IS24::SearchResult.new(result) }
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