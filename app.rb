require('sinatra')
require('sinatra/reloader')
require('./lib/stylist')
require('./lib/client')
require('pg')
require('./spec/spec_helper')
also_reload('lib/**/*.rb')

DB = PG.connect({dbname: 'hair_salon'})

before do
  cache_control :public, :no_cache
	cache_control :views, :no_cache
end

get '/'  do
  @stylists = Stylist.all # may use to display all stylists on index if have time
  @clients = Client.all # may use to display all clients on index if have time
	erb(:index)
end

# client routes

get '/clients' do

  erb(:clients)
end

post '/clients/new' do

  erb(:clients)
end

get '/clients/:id' do
  id = params.fetch('id')

  erb(:client)
end

patch '/clients/:id' do
  id = params.fetch('id')

  erb(:client)
end

delete '/clients/:id' do
  id = params.fetch('id')

  erb(:clients)
end

# stylist routes

get '/stylists' do

  erb(:stylists)
end

post '/stylists/new' do

  erb(:stylists)
end

get '/stylists/:id' do
  id = params.fetch('id')

  erb(:stylist)
end

patch '/stylists/:id' do
  id = params.fetch('id')

  erb(:stylist)
end

delete '/stylists/:id' do
  id = params.fetch('id')

  erb(:stylists)
end
