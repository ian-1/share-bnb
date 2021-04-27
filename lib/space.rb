class Space

  def self.create(name:)
    DatabaseConnection.query("INSERT INTO space (name) VALUES ('#{name}')")
  end

end
