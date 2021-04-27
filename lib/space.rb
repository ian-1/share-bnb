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
    result.map { |row| Space.new(name: row['name'], description: row['description'],
              price_per_night: row['price_per_night']) }
  end

  def self.update(name:)
    DatabaseConnection.query("UPDATE space SET availibility = false WHERE name = '#{name}';")
  end
end
