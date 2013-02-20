module IS24
  class Attachment
    
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
    
    def created_at
      @created_at ||= Time.parse(@attributes['@creationDate'])
    end
    
    def updated_at
      @updated_at ||= Time.parse(@attributes['@lastModificationDate'])
    end
    
    def picture?
      type == 'Picture'
    end
    
    def video?
      type == 'VideoFile'
    end
    
    def href
      @href ||= @attributes['@xlink.href']
    end
    
    def title
      @title ||= @attributes['title']
    end
    
    def floorplan
      @floorplan ||= @attributes['floorplan']
    end
    
    def versions
      if @attributes['urls'].present? && @attributes['urls'].any?
        @versions ||= @attributes['urls'].first['url'].collect do |version|
          { :href => version['@href'], :size => "#{version['@scale']}".gsub('SCALE_', '') }
        end
      end
    end
    
    def url
      @url ||= @attributes['url']
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