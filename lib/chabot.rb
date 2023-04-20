require 'http'
require 'httparty'
require 'json'
require 'dotenv'
Dotenv.load


class Chatbot
  include HTTParty

  BASE_URL = "https://api.openai.com/v1/engines/davinci-codex/completions"
  API_KEY = ENV["OPENAI_API_SECRET"] # Remplacez "votre_clé_API" par la clé API que vous avez obtenue sur le site d'OpenAI

  def initialize
    @headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{API_KEY}"
    }
  end

  def chat(prompt)
    body = {
      "prompt" => "#{prompt} \n\n Utilisateur : ",
      "max_tokens" => 50,
      "temperature" => 0.8
    }.to_json

    response = self.class.post(BASE_URL, body: body, headers: @headers)

    if response.code == 200
      assistant_response = response.parsed_response["choices"][0]["text"].strip
      puts "Assistant : #{assistant_response}"
    else
      puts "Erreur : #{response.code} - #{response.message}"
    end
  end
end

chatbot = Chatbot.new

