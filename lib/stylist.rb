class Stylist
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id, nil).to_i
  end

  def self.all
    returned_stylists = DB.exec('SELECT * FROM stylists;')
    stylists = []
    returned_stylists.each do |stylist|
      name = stylist.fetch('name')
      id = stylist.fetch('id')
      stylists.push(Stylist.new({name: name, id: id}))
    end
    stylists
  end

  def save
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def self.find(id)
    Stylist.all.each do |stylist|
      if stylist.id == id
        return stylist
      end
    end
  end

  def clients
    clients = []
    Client.all.each do |client|
      if client.stylist_id == self.id
        clients.push(client)
      end
    end
    clients
  end

  def ==(another_stylist)
    self.id == another_stylist.id
  end
end
