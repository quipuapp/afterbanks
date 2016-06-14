require 'afterbanks/request'
require 'afterbanks/response'
require 'afterbanks/configuration'
require 'date'

module Afterbanks
  class Client
    attr_accessor :service_key, :service, :user, :pass, :pass2, :document_type

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
        pass: pass,
        pass2: pass2,
        document_type: document_type }
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
      default_options[:pass2] = pass2 if pass2
      default_options[:documentType] = document_type if document_type

      request_options = default_options.merge(options)

      request = Request.new(self, :post, '/serviceV3/', request_options)
      response = request.perform

      Response::Products.new(response, request)
    end

    def transactions(options = {})
      default_options = { servicekey: service_key,
                          service: service,
                          user: user,
                          pass: pass }
      default_options[:pass2] = pass2 if pass2
      default_options[:documentType] = document_type if document_type

      request_options = default_options.merge(options)

      request_options[:startdate] ||= Date.today.strftime('%d-%m-%Y')

      request = Request.new(self, :post, '/serviceV3/', request_options)
      response = request.perform

      Response::Transactions.new(response, request)
    end
  end
end
