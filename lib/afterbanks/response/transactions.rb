require 'afterbanks/response/transactions/transaction'

module Afterbanks
  class Response
    class Transactions < Response
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
