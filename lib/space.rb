class Space
  attr_reader :id, :name, :description, :price_per_night, :available, :user_id

  def initialize(id:, name:, description:, price_per_night:, available:, user_id:)
    @id = id
    @name = name
    @description = description
    @price_per_night = price_per_night
    @available = available
    @user_id = user_id
  end

  def unavailable
    sql = "UPDATE space SET availibility = false WHERE id = '#{@id}';"
    DatabaseConnection.query(sql)
  end

  class << self
    def create(name:, description:, price_per_night:, user_id:)
      columns = 'name, description, price_per_night, user_id'
      values = "'#{name}', '#{description}', '#{price_per_night}', '#{user_id}'"
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
        available: result['availibility'],
        user_id: result['user_id']
      )
    end
  end
end
