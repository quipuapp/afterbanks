require 'afterbanks/response/forms/form'

module Afterbanks
  class Response
    class Forms < Response
      def forms
        response.map { |form| Form.new(form) }
      end
    end
  end
end
