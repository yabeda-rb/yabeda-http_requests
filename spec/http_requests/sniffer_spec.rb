# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Yabeda::HttpRequests::Sniffer do
  subject(:middleware) { described_class.new }

  let(:data_item) { double }
  let(:next_middleware) { double }

  before do
    allow(data_item).to receive_message_chain(:request, :host) { 'HOST' }
    allow(data_item).to receive_message_chain(:request, :method) { 'METHOD' }
    allow(data_item).to receive_message_chain(:request, :port) { 'PORT' }
    allow(data_item).to receive_message_chain(:response, :timing) { 'TIMING' }
    allow(data_item).to receive_message_chain(:response, :status) { 'STATUS' }

    allow(Yabeda).to receive_message_chain(:http_request_total, :increment) {}
    allow(Yabeda).to receive_message_chain(:http_response_total, :increment) {}
    allow(Yabeda).to receive_message_chain(:http_response_duration, :measure) {}
  end

  it 'chain middleware' do
    expect(next_middleware).to receive(:call)
    middleware.request(data_item) { next_middleware.call }
  end
end
