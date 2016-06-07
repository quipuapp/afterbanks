require 'afterbanks/response/forms/form'

module Afterbanks
  module Response
    class Forms
      attr_reader :request, :response

      def initialize(response, request)
        @response = response
        @request = request
      end

      def forms
        response.map { |form| Afterbanks::Response::Forms::Form.new(form) }
      end
    end
  end
end
