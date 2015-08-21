require 'spec_helper'
require 'pry'

describe Client do
  describe '.all' do
    it 'starts off with no stylists' do
      expect(Client.all).to eq []
    end
  end

  describe '#name' do
    it 'tells you its name' do
      client = Client.new({ name: 'Tacocat de Gato', id: nil })
      expect(client.name).to eq 'Tacocat de Gato'
    end
  end

  describe '#id' do
    it 'sets its ID when you save it' do
      client = Client.new({name: 'Tacocat de Gato', id: nil})
      client.save()
      expect(client.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe '#save' do
    it 'lets you save stylists to the database' do
      client = Client.new({name: 'Tacocat de Gato', id: nil})
      client.save()
      expect(Client.all()).to(eq([client]))
    end
  end

  describe 'update' do
    it 'lets you update stylists in the database' do
      client = Client.new({name: 'Tacocat de Gato', id: nil})
      client.save
      client.update({name: 'Tacocat de Perro'})
      expect(client.name).to(eq('Tacocat de Perro'))
    end
  end

  describe 'delete' do
    it 'lets you delete a client from the database' do
      client1 = Client.new({name: 'Tacocat de Gato', id: nil})
      client1.save
      client2 = Client.new({name: 'Tacocat de Perro', id: nil})
      client2.save
      client1.delete
      expect(Client.all).to(eq([client2]))
    end
  end

  describe '#==' do
    it 'is the same client if it has the same name' do
      client1 = Client.new({name: 'Tacocat de Gato', id: nil})
      client2 = Client.new({name: 'Tacocat de Gato', id: nil})
      expect(client1).to(eq(client2))
    end
  end

  describe '.find' do
    it 'finds the client by its id' do
      client1 = Client.new({name: 'Tacocat de Gato', id: nil})
      client2 = Client.new({name: 'Tacocat de Gato', id: nil})
      client1.save
      client2.save
      expect(Client.find(client1.id)).to eq client1
    end
  end

end
