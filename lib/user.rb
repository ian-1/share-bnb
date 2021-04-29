require 'bcrypt'

class User
  attr_reader :id, :name, :email

  def initialize(id:, name:, email:)
    @id = id
    @name = name
    @email = email
  end

  class << self
    def create(name:, email:, password:)
      # encrypt the plantext password
      encrypted_password = BCrypt::Password.create(password)

      columns = 'name, email, password'
      values = "'#{name}','#{email}', '#{encrypted_password}'"
      returning = 'id, name, email'
      sql = "INSERT INTO app_user (#{columns}) VALUES(#{values}) RETURNING #{returning};"
      result = DatabaseConnection.query(sql).first
      new_from_db_result(result)
    end

    def find(id:)
      sql = "SELECT * FROM app_user WHERE id = '#{id}';"
      result = DatabaseConnection.query(sql).first
      new_from_db_result(result)
    end

    def authenticate(email:, password:)
      sql = "SELECT * FROM app_user WHERE email = '#{email}';"
      
      result =  DatabaseConnection.query(sql).first
      
      if result.nil?
        return nil
      else
        result
      end

      return unless BCrypt::Password.new(result['password']) == password
  
      User.new(id: result['id'], name: result['name'], email: result['email'])
    end

    private

    def new_from_db_result(result)
      User.new(
        id: result['id'],
        name: result['name'],
        email: result['email']
      )
    end
  end
end
