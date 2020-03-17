require 'yabeda/http'
require 'prometheus/client'
require 'yabeda/prometheus'
require 'rack'
require './worker'


Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') }

  ::Yabeda.configure!
  ::Yabeda::Prometheus::Exporter.start_metrics_server!
end
