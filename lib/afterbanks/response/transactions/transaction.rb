module Afterbanks
  module Response
    class Transactions
      class Transaction
        def initialize(form_data)
          form_data.each do |key, value|
            if key != :date && key != :date2
              singleton_class.class_eval { attr_reader key }
            end

            instance_variable_set("@#{key}", value)
          end
        end

        def date
          Date.strptime(@date, '%d-%m-%Y')
        end

        def date2
          Date.strptime(@date2, '%d-%m-%Y')
        end
      end
    end
  end
end


