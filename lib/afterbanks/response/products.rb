require 'afterbanks/response/products/product'

module Afterbanks
  module Response
    class Products
      attr_reader :request, :response

      def initialize(response, request)
        @response = response
        @request = request
      end

      def products
        response.map { |product| Afterbanks::Response::Products::Product.new(product) }
      end
    end
  end
end
