module Afterbanks
  class Response
    class Me < Response
      def limit
        response[:limit].to_i
      end

      def counter
        response[:counter].to_i
      end

      def remaining_calls
        response[:remaining_calls].to_i
      end

      def date_renewal
        Date.strptime(response[:date_renewal], '%Y-%m-%d')
      end
    end
  end
end
