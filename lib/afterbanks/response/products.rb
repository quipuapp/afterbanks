require 'afterbanks/response/products/product'

module Afterbanks
  class Response
    class Products < Response
      def products
        response.map { |product| Afterbanks::Response::Products::Product.new(product) }
      end
    end
  end
end
