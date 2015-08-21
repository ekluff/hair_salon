require('sinatra')
require('sinatra/reloader')
require('./lib/stylist')
require('./lib/client')
require('pg')
require 'pry'
also_reload('lib/**/*.rb')

DB = PG.connect({dbname: 'hair_salon'})

before do
  cache_control :public, :no_cache
	cache_control :views, :no_cache
end

get '/'  do # done
	erb(:index)
end

# stylist routes

get '/stylists' do # done
  @stylists = Stylist.all

  erb(:stylists)
end

post '/stylists/new' do # done
  name = params.fetch('name')

  Stylist.new({name: name}).save

  @stylists = Stylist.all

  erb(:stylists)
end

get '/stylists/:id' do # done
  id = params.fetch('id').to_i

  @stylist = Stylist.find(id)
  @clients = @stylist.clients

  erb(:stylist)
end

patch '/stylists/:id' do # done
  id = params.fetch('id').to_i
  name = params.fetch('name')

  @stylist = Stylist.find(id)
  @stylist.update({name: name})
  @clients = @stylist.clients

  erb(:stylist)
end

delete '/stylists/:id' do # done
  id = params.fetch('id').to_i

  stylist = Stylist.find(id)
  stylist.delete unless Stylist.all == []

  @stylists = Stylist.all

  erb(:stylists)
end

post '/stylists/new/client' do
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id').to_i

  client = Client.new({name: name, stylist_id: stylist_id})
  client.save

  @stylist = Stylist.find(stylist_id)
  @clients = @stylist.clients

  erb(:stylist)
end

# client routes

get '/clients' do # done
  @clients = Client.all
  @stylists = Stylist.all

  erb(:clients)
end

post '/clients/new' do # done
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id').to_i

  client = Client.new({name: name, stylist_id: stylist_id})
  client.save

  @clients = Client.all
  @stylists = Stylist.all

  erb(:clients)
end

get '/clients/:id' do #done
  id = params.fetch('id').to_i

  @client = Client.find(id)
  @stylist = @client.stylist
  @stylists = Stylist.all

  erb(:client)
end

patch '/clients/:id' do #done
  id = params.fetch('id').to_i
  new_name = params.fetch('new_name')
  new_stylist_id = params.fetch('new_stylist_id').to_i

  @client = Client.find(id)

  if new_name == ""
    new_name = @client.name
  end

  @client.update({name: new_name, stylist_id: new_stylist_id})
  @stylist = @client.stylist
  @stylists = Stylist.all

  erb(:client)
end

delete '/clients/:id' do #done
  id = params.fetch('id').to_i

  client = Client.find(id)
  client.delete unless Client.all == []

  @clients = Client.all
  @stylists = Stylist.all

  erb(:clients)
end
