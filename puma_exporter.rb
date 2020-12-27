require 'sinatra'
require 'json'
require 'net/http'
require './stats_extractor'

class PumaExporter < Sinatra::Base
  get '/health' do
    status 204
  end

  get '/metrics' do
    StatsExtractor.new(
      JSON.parse(
        Net::HTTP.get(
          URI(ENV.fetch('CONTROL_APP_URL', 'http://127.0.0.1:9293') + '/stats')
        )
      )
    ).perform.join("\n") + "\n"
  end
end
