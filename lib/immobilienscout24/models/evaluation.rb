module IS24
  class Evaluation < Api

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

    def available?
      @attributes.present? && @attributes['status'] == 'OK'
    end

    def details_page_url
      @details_page_url ||= @attributes['realtorDirectory']['dpurl']
    end

    def details_page_url_mobile
      @details_page_url_mobile ||= @attributes['realtorDirectory']['mdpurl']
    end

    def has_badge?
      @attributes['realtor']['bpu'].present?
    end

    def badge_picture_url
      @badge_picture_url ||= has_badge? ? @attributes['realtor']['bpu'] : ''
    end

    def evaluation_switch_status
      @evaluation_switch_status ||= @attributes['realtor']['ess']
    end

    def evaluations_last_year
      @evaluations_last_year ||= @attributes['evaluations']['MONTHS_12']
    end

    def evaluations_last_18_months
      @evaluations_last_18_months ||= @attributes['evaluations']['MONTHS_18']
    end

    def evaluations_last_two_years
      @evaluations_last_two_years ||= @attributes['evaluations']['MONTHS_24']
    end

    def evaluations_overall
      @evaluations_overall ||= @attributes['evaluations']['ALL']
    end

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def self.by_company_wide_id(company_wide_id, encryption_key)
      return self.new(IS24::Api.new.get("evaluation/v4.0/realtor/#{self.encrypted_company_wide_id(company_wide_id, encryption_key)}/evaluationinfo/"))
    end

    def self.encrypted_company_wide_id(company_wide_id, encryption_key)
      cipher = OpenSSL::Cipher::Cipher.new('AES-128-ECB')
      cipher.encrypt
      cipher.key = Base64.decode64(encryption_key)

      crypt = cipher.update(company_wide_id)
      crypt << cipher.final

      return crypt.unpack('H*').first
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