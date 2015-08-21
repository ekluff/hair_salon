require('capybara/rspec')
require('./app')
require('sinatra')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('visiting the stylists page', {:type => :feature}) do
  it 'allows a user to visit a page that displays all the stylists' do
    visit('/')
    click_link('stylists')
    expect(page).to have_content('Stylists')
  end
end

describe('adding a new stylist', {:type => :feature}) do
  it 'allows the user to add a new stylist' do
    visit('/stylists')
    fill_in('name', with: 'Tacocat de Gato')
    click_button('+ stylist')
    expect(page).to have_content('Tacocat de Gato')
  end
end

describe('visiting a stylist page', {:type => :feature}) do
  it 'allows you to add click the name of a stylist and see their name and clients' do
    stylist = Stylist.new({name: 'Tacocat de Gato'})
    stylist.save
    client = Client.new({name: 'Tacocat de Perro', stylist_id: stylist.id})
    client.save
    visit('/stylists')
    click_link('Tacocat de Gato')
    expect(page).to have_content('Tacocat de Gato')
    expect(page).to have_content('Tacocat de Perro')
  end
end

describe('adding a new client to on the stylist page') do
  it 'allows you to add a client to a stylist from the stylist detail page' do
    stylist = Stylist.new({name: 'Tacocat de Gato'})
    stylist.save
    visit("/stylists/#{stylist.id}")
    fill_in('client_name', with: 'Tacocat de Perro')
    click_button('+ client')
    expect(page).to have_content('Tacocat de Perro')
  end
end

describe('changing the name of a stylist') do
  it 'allows you to change the name of a stylist' do
    stylist = Stylist.new({name: 'Tacocat de Gato'})
    stylist.save
    visit("/stylists/#{stylist.id}")
    fill_in('stylist_name', with: 'Tacocat de Perro')
    click_button('change')
    expect(page).to have_content('Tacocat de Perro')
  end
end

describe('deleting a stylist') do
  it 'allows you to delete a stylist and delivers you to back to the stylists page' do
    stylist = Stylist.new({name: 'Tacocat de Gato'})
    stylist.save
    visit("/stylists/#{stylist.id}")
    click_button('delete stylist')
    expect(page).not.to have_content('Tacocat de Gato')
  end
end
