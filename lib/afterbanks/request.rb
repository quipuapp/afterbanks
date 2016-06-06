require 'addressable/uri'
require 'http'
require 'afterbanks/error'

module Afterbanks
  class Request
    def initialize(client, request_method, path, options = {})
      @client = client
      @request_method = request_method
      @uri = Addressable::URI.parse(path.start_with?('http') ? path : client.configuration.endpoint + path)
      @path = @uri.path
      @options = options
    end

    # @return [Array, Hash]
    def perform
      options_key = @request_method == :get ? :params : :form
      response = http_client.public_send(@request_method, @uri.to_s, options_key => @options)
      response_body = response.body.empty? ? '' : symbolize_keys!(response.parse)
      response_headers = response.headers
      fail_or_return_response_body(response.code, response_body, response_headers)
    end

    private

    # @return [HTTP::Client, HTTP]
    def http_client
      HTTP
    end

    def fail_or_return_response_body(code, body, headers)
      error = error(code, body, headers)
      raise(error) if error
      body
    end

    def error(code, body, headers)
      klass = Afterbanks::Error::ERRORS[code]
      if !klass.nil?
        klass.from_response(body)
      end
    end

    def symbolize_keys!(object)
      if object.is_a?(Array)
        object.each_with_index do |val, index|
          object[index] = symbolize_keys!(val)
        end
      elsif object.is_a?(Hash)
        object.keys.each do |key|
          object[key.to_sym] = symbolize_keys!(object.delete(key))
        end
      end

      object
    end
  end
end
