module Afterbanks
  class Error < StandardError
    # @return [Integer]
    attr_reader :code, :response

    ClientError = Class.new(self)

    # Raised when Afterbanks returns the HTTP status code 202...?
    MalformedJson = Class.new(ClientError)

    # Raised when Afterbanks returns the HTTP status code 400
    BadRequest = Class.new(ClientError)

    # Raised when Afterbanks returns the HTTP status code 401
    Unauthorized = Class.new(ClientError)

    # Raised when Afterbanks returns the HTTP status code 403
    Forbidden = Class.new(ClientError)

    # Raised when Afterbanks returns the HTTP status code 404
    NotFound = Class.new(ClientError)

    # Raised when Afterbanks returns the HTTP status code 417
    ExpectationFailed = Class.new(ClientError)

    # Raised when Afterbanks encounters an invalid servicekey
    InvalidServiceKey = Class.new(ClientError)

    # Raised when Afterbanks returns a 5xx HTTP status code
    ServerError = Class.new(self)

    # Raised when Afterbanks returns the HTTP status code 500
    InternalServerError = Class.new(ServerError)

    # Raised when Afterbanks returns the HTTP status code 502
    BadGateway = Class.new(ServerError)

    # Raised when Afterbanks returns the HTTP status code 503
    ServiceUnavailable = Class.new(ServerError)

    # Raised when Afterbanks returns the HTTP status code 504
    GatewayTimeout = Class.new(ServerError)

    # Format Errors
    FormatError = Class.new(self)

    # Invalid Transaction Error
    InvalidTransaction = Class.new(FormatError)

    # Missing Product on Transactions Error
    MissingProduct = Class.new(FormatError)

    # Missing Transactions on Transactions Error
    MissingTransactions = Class.new(FormatError)

    ERRORS = {
      202 => Afterbanks::Error::MalformedJson,
      400 => Afterbanks::Error::BadRequest,
      401 => Afterbanks::Error::Unauthorized,
      403 => Afterbanks::Error::Forbidden,
      404 => Afterbanks::Error::NotFound,
      417 => Afterbanks::Error::ExpectationFailed,
      500 => Afterbanks::Error::InternalServerError,
      502 => Afterbanks::Error::BadGateway,
      503 => Afterbanks::Error::ServiceUnavailable,
      504 => Afterbanks::Error::GatewayTimeout,
    }.freeze

    module Code
      INVALID_PASSWORD = 3
      INVALID_SERVICE_KEY = 50
    end

    # Create a new error from an HTTP response
    #
    # @param body [String]
    # @param headers [Hash]
    # @return [Afterbanks::Error]
    class << self
      def from_response(body)
        message, code = parse_error(body)
        new(message, code)
      end

      private

      def parse_error(body)
        if body.nil? || body.empty?
          ['', nil]
        elsif body[:error]
          [body[:error], nil]
        elsif body[:message]
          [body[:message], nil]
        end
      end
    end

    # Initializes a new Error object

    # @param message [Exception, String]
    # @param code [Integer]
    # @return [Afterbanks::Error]
    def initialize(message = '', code = nil, response = nil)
      super(message)
      @code = code
      @response = response
    end
  end
end
