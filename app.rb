require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'json'
require 'net/http'

get '/' do
    signals = Array.new
    signals.push(ENV['SIGNAL_1'])
    signals.push(ENV['SIGNAL_2'])
    
    token = ENV['TOKEN']
    
    signals.each do |signal|
        uri = URI.parse("https://api.nature.global/1/signals/#{signal}/send")
        http = Net::HTTP.new(uri.host, uri.port)
        
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        
        req = Net::HTTP::Post.new(uri.request_uri)
        req["Authorization"] = "bearer #{token}"
        req["Accept"] = "application/json"
        req["Content-Type"] = "application/x-www-form-urlencoded"
        
        
        res = http.request(req)
        puts res.code, res.msg
        puts res.body
    end

    
end
