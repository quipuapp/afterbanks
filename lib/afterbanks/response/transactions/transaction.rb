module Afterbanks
  class Response
    class Transactions < Response
      class Transaction
        attr_accessor :requested_product, :service, :data

        def initialize(requested_product, service, data)
          @requested_product = requested_product
          @service = service
          @data = data

          data.each do |key, value|
            if key != :date && key != :date2
              singleton_class.class_eval { attr_reader key }
            end

            instance_variable_set("@#{key}", value)
          end
        end

        def date
          Date.strptime(@date, '%d-%m-%Y')
        rescue
          raise Afterbanks::Error::InvalidTransaction.new(error_message, nil, self)
        end

        def date2
          Date.strptime(@date2, '%d-%m-%Y')
        rescue
          raise Afterbanks::Error::InvalidTransaction.new(error_message, nil, self)
        end

        private

        def error_message
          "Invalid Transaction #{data} (Service: #{service}, Product: #{requested_product})"
        end
      end
    end
  end
end


