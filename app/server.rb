require 'sinatra'
require 'json'
require 'webrick'
require './Controllers/client/heroesController.rb'
require './Controllers/scraperController.rb'
configure do
  set :bind, '0.0.0.0'
end

heroesController = ClientHeroController.new()
scrapingController = ScrapingController.new()
get '/' do
  begin
  content_type :json
  heroesController.displayHeroes
  rescue TypeError => e
    p e
  end
end

post '/' do
  begin
 query = JSON.parse(request.body.read)
 heroesController.trackHeroes(query)
  rescue StandardError => e
    p e
  end
end

delete '/' do
    begin
      query = JSON.parse(request.body.read)
      heroesController.deleteHeroByName(query)
  rescue StandardError => e
    p e
  end
end

get '/test' do
  begin
      query = JSON.parse(request.body.read)
      scrapingController.getAllHeroNames()
  rescue StandardError => e
    p e
  end  
end


