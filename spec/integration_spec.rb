require('capybara/rspec')
require('./app')
require('sinatra')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the stylist path') do
  describe('visiting the stylists page', {:type => :feature}) do
    it 'allows you to visit a page that displays all the stylists' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      visit('/')
      click_link('stylists')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('adding a new stylist', {:type => :feature}) do
    it 'allows the user to add a new stylist on the stylists page' do
      visit('/stylists')
      fill_in('name', with: 'Tacocat de Gato')
      click_button('+ stylist')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('visiting a stylist page', {:type => :feature}) do
    it 'allows you to view the name and clients of a stylist' do
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

  describe('adding a new client to on the stylist page', {:type => :feature}) do
    it 'allows you to add a client to a stylist from the stylist page' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      visit("/stylists/#{stylist.id}")
      fill_in('name', with: 'Tacocat de Perro')
      click_button('+ client')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('changing the name of a stylist', {:type => :feature}) do
    it 'allows you to change the name of a stylist from the stylist page' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      visit("/stylists/#{stylist.id}")
      fill_in('new_name', with: 'Tacocat de Perro')
      click_button('save')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('clicking the delete button on the stylist page', {:type => :feature}) do
    it 'allows you to delete a stylist and delivers you to back to the stylists page' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist2 = Stylist.new({name: 'Tacocat de Perro'})
      stylist.save
      stylist2.save
      visit("/stylists/#{stylist.id}")
      click_button('delete')
      expect(page).to have_no_content('Tacocat de Gato')
    end
  end
end

describe('the client path') do
  describe('visiting the clients page', {:type => :feature}) do
    it 'allows a user to visit a page that displays all the clients and their stylists' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      client = Client.new({name: 'Tacocat de Perro', stylist_id: stylist.id})
      client.save
      visit('/clients')
      expect(page).to have_content('Tacocat de Perro')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('filling in client name and clicking submit on the clients page', {:type => :feature}) do
    it 'allows you to add a new client' do
      visit('/clients')
      fill_in('name', with: 'Tacocat de Gato')
      click_button('+ client')
      expect(page).to have_content('Tacocat de Gato')
    end
  end

  describe('visiting a client page', {:type => :feature}) do
    it 'allows you to click the name of a client and see their name and stylist' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      client = Client.new({name: 'Tacocat de Perro', stylist_id: stylist.id})
      client.save
      visit('/clients')
      click_link('Tacocat de Gato')
      expect(page).to have_content('Tacocat de Gato')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('changing the name of a client', {:type => :feature}) do
    it 'allows you to change the name of a client on the client page' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      client = Client.new({name: 'Tacocat de Perro', stylist_id: stylist.id})
      client.save
      visit("/clients/#{client.id}")
      fill_in('new_name', with: 'Tacocat de Perro')
      click_button('save')
      expect(page).to have_content('Tacocat de Perro')
    end
  end

  describe('clicking a client delete button', {:type => :feature}) do
    it 'allows you to delete a client and delivers you to back to the clients page' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      client = Client.new({name: 'Tacocat de Perro', stylist_id: stylist.id})
      client.save
      visit("/clients/#{client.id}")
      click_button('delete')
      expect(page).to have_no_content('Tacocat de Gato')
    end
  end
end
