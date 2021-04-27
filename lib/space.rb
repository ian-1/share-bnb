class Space
  attr_reader :name, :description, :price_per_night

  def initialize(name:, description:, price_per_night:)
    @name = name
    @description = description
    @price_per_night = price_per_night
  end

  def self.create(name:, description:, price_per_night:)
    DatabaseConnection.query("INSERT INTO space (name, description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}')")
  end

  def self.all
    result = DatabaseConnection.query('SELECT * FROM space;')
    Space.new(name: result[0]['name'], description: result[0]['description'],
              price_per_night: result[0]['price_per_night'])
  end

  def self.update(name:)
    DatabaseConnection.query("UPDATE space SET availibility = false WHERE name = '#{name}';")
  end
end
