# frozen_string_literal: true

RSpec.describe Yabeda::HttpRequests do
  it 'has a version number' do
    expect(Yabeda::HttpRequests::VERSION).not_to be nil
  end

  describe 'metrics' do
    # rubocop: disable Layout/MultilineMethodCallIndentation
    it 'holds the proper data' do
      expect { Faraday.get 'https://example.net/' }.to \
        increment_yabeda_counter(Yabeda.http_request_total)
          .with({ method: 'GET', host: 'example.net', port: 443 } => 1)
      .and \
        increment_yabeda_counter(Yabeda.http_response_total)
          .with({ method: 'GET', host: 'example.net', port: 443, status: 200 } => 1)
      .and \
        measure_yabeda_histogram(Yabeda.http_response_duration)
          .with({ method: 'GET', host: 'example.net', port: 443, status: 200 } => be > 0)
    end
    # rubocop: enable Layout/MultilineMethodCallIndentation
  end
end
