class Space
  attr_reader :id, :name, :description, :price_per_night, :available

  def initialize(id:, name:, description:, price_per_night:, available:)
    @id = id
    @name = name
    @description = description
    @price_per_night = price_per_night
    @available = available
  end

  def unavailable
    DatabaseConnection.query("UPDATE space SET availibility = false WHERE id = '#{@id}';")
  end

  class << self
    def create(name:, description:, price_per_night:)
      DatabaseConnection.query("INSERT INTO space (name, description, price_per_night) VALUES ('#{name}', '#{description}', '#{price_per_night}')")
    end

    def all
      result = DatabaseConnection.query('SELECT * FROM space;')
      result.map { |row| Space.new(
        id: row['id'],
        name: row['name'],
        description: row['description'],
        price_per_night: row['price_per_night'],
        available: row['available']
        )
       }
    end
  end
end
