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
    
    def created_at
      return Time.parse(@attributes['@creationDate']) if @attributes['@creationDate'].present?
      return Time.parse(@attributes['@creation']) if @attributes['@creation'].present?
    end
    
    def updated_at
      return Time.parse(@attributes['@lastModificationDate']) if @attributes['@lastModificationDate'].present?
      return Time.parse(@attributes['@modification']) if @attributes['@modification'].present?
    end
    
    def published_at
      @published_at ||= Time.parse(@attributes['@publishDate']) if @attributes['@publishDate'].present?
    end

    def media_type
      @media_type ||= "#{@attributes['@xsi.type']}".split(':').last if @attributes.present?
    end
    
    def picture?
      media_type == 'Picture'
    end
    
    def video?
      %w(StreamingVideo VideoFile).include?(media_type)
    end
    
    def pdf?
      media_type == 'PDFDocument'
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
    
    def title_picture
      @title_picture ||= @attributes['titlePicture']
    end
    
    def original_picture_url
      @original_picture_url = "#{versions.first[:href]}".split('/ORIG').first if versions.any?
    end
    
    def versions
      if @attributes['urls'].present? && @attributes['urls'].any?
        @versions ||= @attributes['urls'].first['url'].collect do |version|
          { :href => version['@href'], :size => "#{version['@scale']}".gsub('SCALE_', '') }
        end
      end
    end
    
    def url
      return original_picture_url if picture?
      return video_id if video?
      return @attributes['url'] if @attributes['url'].present?
      return @attributes['@xlink.href']
    end
    
    def video_id
      @video_id ||= @attributes['videoId']
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