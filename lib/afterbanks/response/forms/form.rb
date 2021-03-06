module Afterbanks
  class Response
    class Forms < Response
      class Form
        def initialize(form_data)
          form_data.each do |key, value|
            singleton_class.class_eval { attr_reader key }

            instance_variable_set("@#{key}", value)
          end
        end
      end
    end
  end
end
