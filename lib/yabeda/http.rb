# frozen_string_literal: true

require 'yabeda/http/version'
require 'yabeda/http/sniffer'
require 'yabeda'
require 'sniffer'

require 'byebug'
module Yabeda
  # Common module
  module Http
    Yabeda.configure do
      group :http

      counter :requests_total,
              comment: 'A counter of the total number of external HTTP \
                         requests.',
              tags: %i[host]

      ::Sniffer.config do |c|
        c.enabled = true
        c.middleware do |chain|
          chain.add(Yabeda::Http::Sniffer)
        end
      end
    end

    class Error < StandardError; end
    # Your code goes here...
  end
end
