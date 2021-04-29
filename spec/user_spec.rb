require 'user'
# require 'database_helpers'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = described_class.create(name: 'Mr Name', email: 'test@example.com', password: 'password123')

      result = DatabaseConnection.query('SELECT * FROM app_user;').first

      expect(user).to be_a described_class
      expect(user.id).to eq result['id']
      expect(user.name).to eq 'Mr Name'
      expect(user.email).to eq 'test@example.com'
    end

    it 'hashes the password using BCrypt' do
      allow(BCrypt::Password).to receive(:create)

      described_class.create(name: 'Mr Name', email: 'test@example.com', password: 'password123')
      expect(BCrypt::Password).to have_received(:create).with('password123')
    end
  end

  describe '.find' do
    it 'finds a user by ID' do
      user = described_class.create(name: 'Mr Name', email: 'test@example.com', password: 'password123')

      result = DatabaseConnection.query('SELECT * FROM app_user;').first
      found_user = described_class.find(id: result['id'])

      expect(found_user.name).to eq user.name
      expect(found_user.email).to eq user.email
    end
  end
end
