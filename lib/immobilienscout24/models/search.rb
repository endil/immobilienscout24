module IS24
  class Search < Api
    
    #
    # Instance Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #
    
    # TODO: features: grouping, matchcount
    def default_search_options(options={})
      {
        pagesize: IS24.config.max_search_results
      }.merge(options)
    end
    
    def by_type_and_radius(real_estate_type, latitude, longitude, radius, criterias = {}, sorting = 'distance', request_full_expose = IS24.config.always_request_full_expose)
      query(:radius, criterias.merge(realestatetype: real_estate_type, geocoordinates: [latitude, longitude, radius].join(';')), sorting, request_full_expose)
    end
    
    def by_type_and_geocode(real_estate_type, geocode, criterias = {}, sorting = 'id', request_full_expose = IS24.config.always_request_full_expose)
      query(:region, criterias.merge(realestatetype: real_estate_type, geocodes: geocode), sorting, request_full_expose)
    end
    
    def by_type_and_geocode_and_channel(real_estate_type, geocode, channel = 'hp', criterias = {}, sorting = 'id', request_full_expose = IS24.config.always_request_full_expose)
      by_type_and_geocode(real_estate_type, geocode, criterias.merge(channel: channel), sorting, request_full_expose)
    end
    
    def by_type_and_geocode_and_channel_and_user(real_estate_type, geocode, channel = 'hp', username = 'me', criterias = {}, sorting = 'id', request_full_expose = IS24.config.always_request_full_expose)
      by_type_and_geocode_and_channel(real_estate_type, geocode, channel, criterias.merge(username: username), sorting, request_full_expose)
    end
    
    def by_type_and_geocode_and_customer_number(real_estate_type, geocode, customer_number, criterias = {}, sorting = 'id', request_full_expose = IS24.config.always_request_full_expose)
      by_type_and_geocode(real_estate_type, geocode, criterias.merge(customernumber: customer_number), sorting, request_full_expose)
    end
    
    def query(search_type, criterias = {}, sorting = 'id', request_full_expose = IS24.config.always_request_full_expose)
      base_url = "search/#{IS24.config.api_version}/search"
      if search_type.present? && %w(radius region).include?(search_type.to_s)
        base_url = "search/#{IS24.config.api_version}/search/#{search_type}"
      end
      
      # build search query
      criterias.merge!(sorting: sorting) if sorting.length > 0
      query_params = default_search_options.merge(criterias)
      query = "#{base_url}?#{query_params.to_query}"
      
      if request_full_expose
        return get_pages(query, { 'Accept' => 'application/json;strict=true' }).collect { |result| IS24::SearchResult.new(result) }
      else
        return get_pages(query).collect { |result| IS24::SearchResult.new(result) }
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