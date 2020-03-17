require 'sidekiq'
require './worker'

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') }
end

class App
  URLS = [
    'https://twitter.com/dsalahutdinov1',
    'https://amplifr.com/en',
    'https://dev.to/amplifr'
  ]

  def call(env)
    jobs_count = rand(100).round
    jobs_count.times { Worker.perform_async(URLS.sample) }

    [
      200,
      {"Content-Type" => "text/html"},
      ["Enqueued #{jobs_count} jobs"]
    ]
  end
end
