# encoding: UTF-8
module IS24
  module Exception

    ERROR_IDENTIFIERS = %w(
      ERROR_COMMON_AUTHENTICATION_REQUIRED
      ERROR_COMMON_AUTHENTICATION_OAUTH_NONCE_EXPIRED
      ERROR_COMMON_ACCESS_DENIED
      ERROR_RESOURCE_NOT_FOUND
      ERROR_COMMON_RESOURCE_NOT_FOUND
      ERROR_COMMON_METHOD_NOT_ALLOWED
      ERROR_COMMON_ACCEPT_TYPE_NOT_APPLICABLE
      ERROR_COMMON_RESOURCE_REQUIRED
      ERROR_COMMON_SCHEMA_VALIDATION_FAILED
      ERROR_COMMON_URL_PARAMETER_REQUIRED
      ERROR_COMMON_URL_PARAMETER_VALIDATION_FAILED
      ERROR_COMMON_URL_PARAMETER_NOT_SUPPORTED
      ERROR_COMMON_HEADER_PARAMETER_VALIDATION_FAILED
      ERROR_COMMON_URL_MULTIPLE_PARAMETERS_NOT_ALLOWED
      ERROR_RESOURCE_NOT_SUPPORTED
      ERROR_RESOURCE_VALIDATION
      ERROR_CONTACT_DETAILS_MISSING
      ERROR_INVALID_COORDINATES
      ERROR_GEOCODING_FAILED
      ERROR_COMMON_MEDIA_TYPE_UNSUPPORTED
      ERROR_COMMON_INTERNAL_SERVER_ERROR
      ERROR_COMMON_NOT_IMPLEMENTED
      ERROR_COMMON_SERVICE_UNAVAILABLE
    )

    def self.translate_into_class_name(error_identifier)
      return "#{error_identifier.gsub('ERROR_','').tableize.classify}"
    end

    ERROR_IDENTIFIERS.each do |error_identifier|
      const_set(self.translate_into_class_name(error_identifier), Class.new(StandardError))
    end

  end
end