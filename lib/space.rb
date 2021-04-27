class Space
  attr_reader :name, :description, :price_per_night

  def initialize(name:, description:, price_per_night:)
    @name = name
    @description = description
    @price_per_night = price_per_night
  end

  def self.create(name:)
    DatabaseConnection.query("INSERT INTO space (name) VALUES ('#{name}')")
  end

end
