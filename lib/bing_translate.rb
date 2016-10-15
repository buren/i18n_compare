require 'bing_translator'

class BingTranslateClient
  attr_reader :translator, :provider

  def initialize
    client_id = ENV.fetch('BING_CLIENT_ID')
    client_secret = ENV.fetch('BING_CLIENT_SECRET')

    @translator = BingTranslator.new(client_id, client_secret)
    @provider = :bing
  end

  def translate(text, from:, to:)
    translator.translate(text, from: from, to: to)
  end
  alias_method :t, :translate
end
