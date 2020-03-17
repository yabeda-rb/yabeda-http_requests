# frozen_string_literal: true

require 'yabeda/http_requests/version'
require 'yabeda/http_requests/sniffer'
require 'yabeda'
require 'sniffer'

module Yabeda
  # Common module
  module HttpRequests
    Yabeda.configure do
      group :http_requests

      counter :total_count,
              comment: 'A counter of the total number of external HTTP \
                         requests.',
              tags: %i[host port method query]

      ::Sniffer.config do |c|
        c.enabled = true
        c.middleware do |chain|
          chain.add(Yabeda::HttpRequests::Sniffer)
        end
      end
    end
  end
end
