class TranslatorController < ApplicationController
  def translate
    text = params[:text]
    from = params[:from]
    to = params[:to]

    full_text_remote_calls = remote_calls(text, from: from, to: to)

    tokens = longest_tokens(text)
    words_remote_calls = remote_calls(tokens, from: from, to: to)

    provider_tokens = words_remote_calls.map do |thread|
      result = thread.join.value

      provider = result.first
      translated_tokens = result.last.split("\n")
      [provider, translated_tokens]
    end.to_h

    results = {}
    full_text_remote_calls.map do |thread|
      result = thread.join.value

      provider = result.first
      translated_text = result.last

      tokens = provider_tokens[provider]
      score = 0
      tokens.each { |token| score += 1 if translated_text.include?(token) }

      results[provider] = {
        text: translated_text,
        confidence: score.to_f / tokens.length,
        tokens: tokens
      }
    end

    render json: results
  end

  private

  def remote_calls(text, from:, to:)
    [GoogleTranslate, BingTranslate, YandexTranslate].map do |klass|
      Thread.new { [klass.provider, klass.t(text, from: from, to: to)] }
    end
  end

  def longest_tokens(text, min_length: 4, max_tokens: 3)
    text.split(' ')
      .reject { |token| token.length < min_length }
      .sort_by { |token| token.length }
      .last(max_tokens)
      .join("\n")
  end
end
