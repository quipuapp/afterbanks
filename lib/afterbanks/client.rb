require 'afterbanks/request'
require 'afterbanks/configuration'
require 'date'

module Afterbanks
  class Client
    attr_accessor :service_key, :service, :user, :pass

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Afterbanks::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end

      yield(self) if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    # @return [Hash]
    def self.credentials
      { service_key: service_key,
        service: service,
        user: user,
        pass: pass }
    end

    def me
      options = { servicekey: service_key }

      Request.new(self, :post, '/me/', options).perform
    end

    def forms(country_code = nil)
      options = {}
      options.merge!(country_code: country_code) if country_code

      Request.new(self, :get, '/forms/', options).perform
    end

    def products(options = {})
      options = { servicekey: service_key,
                  service: service,
                  user: user,
                  pass: pass,
                  products: 'GLOBAL' }

      Request.new(self, :post, '/serviceV3/', options).perform
    end

    def transactions(options = {})
      options = { servicekey: service_key,
                  service: service,
                  user: user,
                  pass: pass }

      options[:startdate] ||= Date.today.strftime('%d-%m-%Y')

      Request.new(self, :post, '/serviceV3/', options).perform
    end
  end
end
