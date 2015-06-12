# encoding: UTF-8
# Include external dependencies
require 'oauth'
require 'multi_json'

require 'immobilienscout24/version'

require 'immobilienscout24/models/config'
require 'immobilienscout24/models/exception'
require 'immobilienscout24/models/helper'
require 'immobilienscout24/models/api'

require 'immobilienscout24/models/me'
require 'immobilienscout24/models/customer'
require 'immobilienscout24/models/user'
require 'immobilienscout24/models/entitlement'
require 'immobilienscout24/models/realtor'

require 'immobilienscout24/models/attachment'
require 'immobilienscout24/models/address'
require 'immobilienscout24/models/contact'
require 'immobilienscout24/models/geohierarchy'
require 'immobilienscout24/models/expose'
require 'immobilienscout24/models/evaluation'
require 'immobilienscout24/models/real_estate'
require 'immobilienscout24/models/search_result'
require 'immobilienscout24/models/search'

module IS24

  def self.configure(configuration = IS24::Config.new)
    yield configuration if block_given?
    @@configuration = configuration
  end

  def self.config
    @@configuration ||= IS24::Config.new
  end

end
