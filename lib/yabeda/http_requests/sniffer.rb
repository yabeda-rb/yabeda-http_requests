# frozen_string_literal: true

module Yabeda
  module HttpRequests
    # Middleware for sniffer gem
    class Sniffer
      def request(data_item)
        Yabeda.http_request_total.increment(
          host: data_item.request.host,
          port: data_item.request.port,
          method: data_item.request.method
        )
      end

      def response(data_item)
        Yabeda.http_response_total.increment(
          host: data_item.request.host,
          port: data_item.request.port,
          method: data_item.request.method,
          duration: duration_in_milliseconds(data_item),
          status: data_item.response.status
        )
      end

      private

      def duration_in_milliseconds(data_item)
        seconds = data_item.response&.timing
        return nil if seconds.nil?

        (seconds * 1000).round
      end
    end
  end
end
