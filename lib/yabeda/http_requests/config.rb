# frozen_string_literal: true

require "anyway"

module Yabeda
  module HttpRequests
    # yabeda-http-requests configuration
    class Config < ::Anyway::Config
      config_name :yabeda_http_requests

      attr_config :buckets
    end
  end
end
