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
    sql = "UPDATE space SET availibility = false WHERE id = '#{@id}';"
    DatabaseConnection.query(sql)
  end

  class << self
    def create(name:, description:, price_per_night:)
      columns = 'name, description, price_per_night'
      values = "'#{name}', '#{description}', '#{price_per_night}'"
      returning = "id, availibility, #{columns}"
      sql = "INSERT INTO space (#{columns}) VALUES (#{values}) RETURNING #{returning};"
      result = DatabaseConnection.query(sql).first
      new_from_db_result(result)
    end

    def all
      result = DatabaseConnection.query('SELECT * FROM space;')
      result.map { |row| new_from_db_result(row) }
    end

    def available_list
      result = DatabaseConnection.query('SELECT * FROM space;')
      result.filter_map do |row|
        new_from_db_result(row) if row['availibility'] == 't'
      end
    end

    def find(id:)
      sql = "SELECT * FROM space WHERE id = '#{id}';"
      result = DatabaseConnection.query(sql).first
      new_from_db_result(result)
    end

    private

    def new_from_db_result(result)
      Space.new(
        id: result['id'],
        name: result['name'],
        description: result['description'],
        price_per_night: result['price_per_night'],
        available: result['availibility']
      )
    end
  end
end
