module Afterbanks
  class Response
    class Products < Response
      class Product
        def initialize(form_data)
          form_data.each do |key, value|
            singleton_class.class_eval { attr_reader key }

            instance_variable_set("@#{key}", value)
          end

          singleton_class.class_eval { alias_method :product_number, :product }
        end

      end
    end
  end
end

