require 'immobilienscout24/version'

# load IS24 models
require 'immobilienscout24/models/config'
require 'immobilienscout24/models/errors'
require 'immobilienscout24/models/api'
require 'immobilienscout24/models/realtor'
require 'immobilienscout24/models/user'

module IS24
  
  def self.configure(configuration = IS24::Config.new)
    yield configuration if block_given?
    @@configuration = configuration
  end
      
  def self.config
    @@configuration ||= IS24::Config.new
  end
  
end
