require 'spec_helper'
require 'pry'

describe Stylist do
  describe '.all' do
    it 'starts off with no stylists' do
      expect(Stylist.all).to eq []
    end
  end

  describe '#name' do
    it 'tells you its name' do
      stylist = Stylist.new({ name: 'Tacocat de Gato', id: nil })
      expect(stylist.name).to eq 'Tacocat de Gato'
    end
  end

  describe '#id' do
    it 'sets its ID when you save it' do
      stylist = Stylist.new({name: 'Tacocat de Gato', id: nil})
      stylist.save()
      expect(stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe '#save' do
    it 'lets you save stylists to the database' do
      stylist = Stylist.new({name: 'Tacocat de Gato', id: nil})
      stylist.save()
      expect(Stylist.all()).to(eq([stylist]))
    end
  end

  describe '#==' do
    it 'is the same stylist if it has the same name' do
      list1 = Stylist.new({name: 'Tacocat de Gato', id: nil})
      list2 = Stylist.new({name: 'Tacocat de Gato', id: nil})
      expect(list1).to(eq(list2))
    end
  end

  describe '.find' do
    it 'finds the stylist by its id' do
      list1 = Stylist.new({name: 'Tacocat de Gato', id: nil})
      list2 = Stylist.new({name: 'Tacocat de Gato', id: nil})
      list1.save
      list2.save
      expect(Stylist.find(list1.id)).to eq list1
    end
  end

  describe '#clients' do
    it 'returns an array of all clients with one stylist_id' do
      stylist = Stylist.new({name: 'Tacocat de Gato'})
      stylist.save
      client1 = Client.new({name: 'Monsignor Schnacky', stylist_id: stylist.id})
      client2 = Client.new({name: 'Edward Vampire', stylist_id: 0})
      client3 = Client.new({name: 'Prince Price Williams', stylist_id: stylist.id})
      client1.save
      client2.save
      client3.save
      expect(stylist.clients).to(eq([client1, client3]))
    end
  end

end
