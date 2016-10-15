require 'google_translate'
require 'bing_translate'
require 'yandex_translate'

BingTranslate = BingTranslateClient.new
GoogleTranslate = GoogleTranslateClient.new
YandexTranslate = YandexTranslateClient.new

module Translator
  UnknownService = Class.new(ArgumentError)

  def self.translate(text, provider, from:, to:)
    _provider_klass(provider).translate(text, from: from, to: to)
  end

  def self.t(*args)
    translate(*args)
  end

  def self._provider_klass(name)
    case name.to_s
    when 'bing'   then BingTranslate
    when 'yandex' then YandexTranslate
    when 'google' then GoogleTranslate
    else
      fail(UnknownService, 'Unknown translator service.')
    end
  end
end
