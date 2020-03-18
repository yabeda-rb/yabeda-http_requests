# frozen_string_literal: true

require 'sidekiq'
require './worker'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') }
end

class App
  URLS = [
    'https://twitter.com',
    'https://amplifr.com/en',
    'https://dev.to/amplifr',
    'https://unknown.domain/path'
  ].freeze

  def call(_env)
    jobs_count = rand(100).round
    jobs_count.times { Worker.perform_async(URLS.sample) }

    [
      200,
      { 'Content-Type' => 'text/html' },
      ["Enqueued #{jobs_count} jobs"]
    ]
  end
end
