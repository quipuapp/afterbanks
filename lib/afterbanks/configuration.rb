module Afterbanks
  class Configuration
    PRODUCTION_ENDPOINT = 'https://www.afterbanks.com'
    SANDBOX_ENDPOINT = 'https://www.afterbanks.com/sandbox'

    attr_accessor :endpoint, :mode

    def endpoint
      @endpoint ||= select_endpoint
    end

    def select_endpoint
      mode == :sanbdox ? SANDBOX_ENDPOINT : PRODUCTION_ENDPOINT
    end

    def mode
      @mode ||= :production
    end
  end
end
