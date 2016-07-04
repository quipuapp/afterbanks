require 'afterbanks/response/transactions/transaction'

module Afterbanks
  class Response
    class Transactions < Response
      def product_info
        product_info = response.find { |product| product[:product] == requested_product }

        if product_info.nil?
          raise Afterbanks::Error::MissingProduct.new("Requested product '#{requested_product}' missing from response", nil, response)
        else
          product_info
        end
      end

      def transactions
        raise Afterbanks::Error::MissingTransactions.new("Missing transactions from product '#{requested_product}'", nil, response) unless product_info[:transactions]

        product_info[:transactions].map { |transaction| Afterbanks::Response::Transactions::Transaction.new(requested_product, requested_service, transaction) }
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

      private

      def requested_product
        request.options[:products]
      end

      def requested_service
        request.options[:service]
      end
    end
  end
end
