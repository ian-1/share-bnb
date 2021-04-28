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
      sql = "INSERT INTO app_user (#{columns}) VALUES(#{values}) RETURNING id;"
      result = DatabaseConnection.query(sql).first
      new(id: result['id'], name: name, email: email)
    end

    def find(id:)
      sql = "SELECT * FROM app_user WHERE id = '#{id}';"
      result = DatabaseConnection.query(sql).first
      User.new(
        id: result['id'],
        name: result['name'],
        email: result['email']
      )
    end
  end
end
