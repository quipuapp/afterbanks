require 'afterbanks/response/transactions/transaction'

module Afterbanks
  module Response
    class Transactions
      attr_reader :request, :response

      def initialize(response, request)
        @response = response
        @request = request
      end

      def product_info
        response.first
      end

      def transactions
        product_info[:transactions].map { |transaction| Afterbanks::Response::Transactions::Transaction.new(transaction) }
      end

      def balance
        product_info[:balance].to_f
      end

      def currency
        product_info[:currency]
      end

      def description
        product_info[:description]
      end

      def product
        product_info[:product]
      end
    end
  end
end
