# frozen_string_literal: true

RSpec.describe Yabeda::Http do
  it 'has a version number' do
    expect(Yabeda::Http::VERSION).not_to be nil
  end

  context 'sdf' do
    before do
      Yabeda.configure!
      Faraday.get 'http://sushi.com/nigiri/sake.json'
    end

    it do
      expect(Yabeda.http_requests_total.values).to(
        eq(
          {
            host: 'sushi.com',
            method: 'GET',
            port: 80,
            query: '/nigiri/sake.json'
          } => 1
        )
      )
    end
  end
end
