# frozen_string_literal: true

require 'sidekiq'
require 'faraday'

class Worker
  include Sidekiq::Worker

  def perform(url)
    Faraday.get url
  end
end
