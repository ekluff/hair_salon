require('sinatra')
require('sinatra/reloader')
require('./lib/stylist')
require('./lib/client')
require('pg')
# require('./spec/spec_helper')
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

# stylist routes

get '/stylists' do
  @stylists = Stylist.all

  erb(:stylists)
end

post '/stylists/new' do
  name = params.fetch('name')

  Stylist.new({name: name}).save

  @stylists = Stylist.all

  erb(:stylists)
end

get '/stylists/:id' do
  id = params.fetch('id').to_i

  @stylist = Stylist.find(id)
  @clients = @stylist.clients

  erb(:stylist)
end

patch '/stylists/:id' do
  id = params.fetch('id').to_i
  new_name = params.fetch('new_name')

  @stylist = Stylist.find(id)
  @stylist.update({name: new_name})
  @clients = @stylist.clients

  erb(:stylist)
end

delete '/stylists/:id' do
  id = params.fetch('id').to_i

  stylist = Stylist.find(id)
  stylist.delete

  @stylists = Stylist.all

  erb(:stylists)
end

# client routes

get '/clients' do # done
  @clients = Client.all
  @stylists = Stylist.all

  erb(:clients)
end

post '/clients/new' do # done
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id')

  client = Client.new({name: name, stylist_id: stylist_id})
  client.save

  @clients = Client.all
  @stylists = Stylist.all

  erb(:clients)
end

get '/clients/:id' do
  id = params.fetch('id').to_i

  @client = Client.find(id)
  @stylist = @client.stylist

  erb(:client)
end

patch '/clients/:id' do
  id = params.fetch('id').to_i
  new_name = params.fetch('new_name')

  @client = Client.find(id)
  @client.update({name: new_name})
  @stylist = @client.stylist

  erb(:client)
end

delete '/clients/:id' do
  id = params.fetch('id').to_i

  client = Client.find(id)
  client.delete

  @clients = Client.all
  @stylist = Stylist.all

  erb(:clients)
end
