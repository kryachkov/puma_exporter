require 'sinatra'
require 'json'
require 'net/http'

class PumaExporter < Sinatra::Base
  STATS_OF_INTEREST = %w(backlog running pool_capacity max_threads).freeze

  get '/health' do
    status 204
  end

  get '/metrics' do
    uri = URI(ENV.fetch('CONTROL_APP_URL', 'http://127.0.0.1:9293') + '/stats')
    puma_control_app_stats = JSON.parse(Net::HTTP.get(uri))
    puma_control_app_stats.slice(*STATS_OF_INTEREST).transform_keys do |k|
      k = 'puma_' + k
    end.map { |k, v| "#{k} #{v}" }.join("\n") + "\n"
  end
end
