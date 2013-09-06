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
      @attributes['statusCode'] == 'EVALUATIONS_AVAILABLE'
    end

    def details_page_url
      @details_page_url ||= @attributes['detailedInfo']['realtorDetailsPageUrl']
    end

    def details_page_url_mobile
      @details_page_url_mobile ||= @attributes['detailedInfo']['mobileDetailsPageUrl']
    end

    def has_premium_badge?
      @has_premium_badge ||= @attributes['detailedInfo']['hasPremiumBadge']
    end

    def premium_badge_url
      @premium_badge_url ||= has_premium_badge? ? @attributes['detailedInfo']['premiumBadgeUrl'] : ''
    end

    def overall_average_evaluation
      @overall_average_evaluation ||= @attributes['detailedInfo']['overallAverageEvaluation']
    end

    def overall_number_of_evaluations
      @overall_number_of_evaluations ||= @attributes['detailedInfo']['overallNumberOfEvaluations']
    end

    def seeker_evaluations_available?
      @attributes['detailedInfo']['seekerEvaluations']['statusCode'] == 'EVALUATIONS_AVAILABLE'
    end

    def seeker_evaluations_overall_average_evaluation
      @seeker_evaluations_overall_average_evaluation ||= @attributes['detailedInfo']['seekerEvaluations']['seekerOverallAverageEvaluation']
    end

    def seeker_evaluations_overall_number_of_evaluations
      @seeker_evaluations_overall_number_of_evaluations ||= @attributes['detailedInfo']['seekerEvaluations']['seekerOverallNumberOfEvaluations']
    end

    def owner_evaluations_available?
      @attributes['detailedInfo']['ownerEvaluations']['statusCode'] == 'EVALUATIONS_AVAILABLE'
    end

    def owner_evaluations_overall_average_evaluation
      @owner_evaluations_overall_average_evaluation ||= @attributes['detailedInfo']['ownerEvaluations']['ownerOverallAverageEvaluation']
    end

    def owner_evaluations_overall_number_of_evaluations
      @owner_evaluations_overall_number_of_evaluations ||= @attributes['detailedInfo']['ownerEvaluations']['ownerOverallNumberOfEvaluations']
    end

    #
    # Class Methods
    # ---------------------------------------------------------------------------------------
    #
    #
    #
    #

    def self.by_company_wide_id(company_wide_id)
      return self.new(IS24::Api.new.get("evaluation/v1.0/realtor/#{company_wide_id}/evaluationinfo/"))
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