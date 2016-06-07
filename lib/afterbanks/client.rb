require 'afterbanks/request'
require 'afterbanks/response'
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

      request = Request.new(self, :post, '/me/', options)
      response = request.perform

      Response::Me.new(response, request)
    end

    def forms(country_code = nil)
      options = {}
      options.merge!(country_code: country_code) if country_code

      request = Request.new(self, :get, '/forms/', options)
      response = request.perform

      Response::Forms.new(response, request)
    end

    def products(options = {})
      default_options = { servicekey: service_key,
                          service: service,
                          user: user,
                          pass: pass,
                          products: 'GLOBAL' }
      request_options = default_options.merge(options)

      Request.new(self, :post, '/serviceV3/', request_options).perform
    end

    def transactions(options = {})
      default_options = { servicekey: service_key,
                          service: service,
                          user: user,
                          pass: pass }
      request_options = default_options.merge(options)

      request_options[:startdate] ||= Date.today.strftime('%d-%m-%Y')

      Request.new(self, :post, '/serviceV3/', request_options).perform
    end
  end
end
