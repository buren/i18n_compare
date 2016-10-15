class YandexTranslateClient
  URL = 'https://translate.yandex.net/api/v1.5/tr.json/translate?'

  attr_reader :api_key, :provider

  def initialize
    @api_key = ENV.fetch('YANDEX_API_KEY')
    @provider = :yandex
  end

  def translate(text, from:, to:)
    response = HTTParty.get(URL + build_params(text, from, to))

    JSON.parse(response.body)['text'].join(' ')
  end
  alias_method :t, :translate

  private

  def build_params(text, from, to)
    [
      "key=#{api_key}",
      "text=#{CGI.escape(text)}",
      "lang=#{[from, to].join('-')}",
      "format=text"
    ].join('&')
  end
end
