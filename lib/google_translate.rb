require 'google/cloud'

class GoogleTranslateClient
  attr_reader :translator, :provider

  def initialize
    api_key = ENV.fetch('GOOGLE_API_KEY')
    gcloud = Google::Cloud.new
    @translator = gcloud.translate(api_key)
    @provider = :google
  end

  def translate(text, from:, to:)
    translation = translator.translate(text, from: from, to: to)
    translation.text
  end
  alias_method :t, :translate
end
