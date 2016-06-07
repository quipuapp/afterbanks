require 'afterbanks/response/forms'
require 'afterbanks/response/me'
require 'afterbanks/response/products'
require 'afterbanks/response/transactions'

module Afterbanks
  class Response
    attr_reader :request, :response

    def initialize(response, request)
      @response = response
      @request = request
    end
  end
end
