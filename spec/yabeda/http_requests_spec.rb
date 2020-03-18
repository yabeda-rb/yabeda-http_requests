# frozen_string_literal: true

RSpec.describe Yabeda::HttpRequests do
  it 'has a version number' do
    expect(Yabeda::HttpRequests::VERSION).not_to be nil
  end

  context 'sdf' do
    before do
      Yabeda.configure!
      Faraday.get 'http://sushi.com/nigiri/sake.json'
    end

    it do
      expect(Yabeda.http_request_total.values).to(
        eq({ host: 'sushi.com', method: 'GET', port: 80 } => 1)
      )
      expect(Yabeda.http_response_total.values.keys.first).to(
        include({
                  host: 'sushi.com', method: 'GET', port: 80,
                  status: 301
                })
      )
    end
  end
end
