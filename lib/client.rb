class Client
  attr_reader :name, :stylist_id, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id).to_i
    @id = attributes.fetch(:id, nil).to_i
  end

  def self.all
    returned_clients = DB.exec('SELECT * FROM clients;')
    clients = []
    returned_clients.each do |client|
      name = client.fetch('name')
      stylist_id = client.fetch('stylist_id')
      id = client.fetch('id')
      clients.push(Client.new({name: name, stylist_id: stylist_id, id: id}))
    end
    clients
  end

  def save
    result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{@name}', '#{@stylist_id}') RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @stylist_id = attributes.fetch(:stylist_id)
    @id = self.id
    DB.exec("UPDATE clients SET name = '#{@name}', stylist_id = '#{@stylist_id}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM clients WHERE id = #{self.id};")
  end

  def self.find(id)
    Client.all.each do |client|
      if client.id == id
        return client
      end
    end
  end

  def ==(another_client)
    self.id == another_client.id
  end
end
