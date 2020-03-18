# frozen_string_literal: true

RSpec.describe Yabeda::HttpRequests do
  it 'has a version number' do
    expect(Yabeda::HttpRequests::VERSION).not_to be nil
  end

  describe 'metrics' do
    before do
      Yabeda.configure!
      Faraday.get 'http://sushi.com/nigiri/sake.json'
    end

    it 'holds the proper data' do
      expect(Yabeda.http_request_total.values).to(
        eq({ host: 'sushi.com', method: 'GET', port: 80 } => 1)
      )
      expect(Yabeda.http_response_total.values.keys.first).to(
        include({
                  host: 'sushi.com', method: 'GET', port: 80,
                  status: 301
                })
      )
      expect(Yabeda.http_response_duration.values.keys.first).to(
        eq(host: 'sushi.com', port: 80, method: 'GET', status: 301)
      )
    end
  end
end
