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

  describe '.authenticate' do
    it 'returns a user given a correct username and password, if one exists' do
      user = User.create(name: 'test', email: 'test@example.com', password: 'password123')
      authenticated_user = User.authenticate(email: 'test@example.com', password: 'password123')

      expect(authenticated_user.id).to eq user.id
    end

    it 'returns nill given an incorrect email address' do
      user = User.create(name: 'test', email: 'test@example.com', password: 'password123')
      expect(User.authenticate(email: 'nottherightemail@me.com', password: 'password123')).to be_nil
    end

    it 'returns nil given an incorrect password' do
      user = User.create(name: 'test', email: 'test@example.com', password: 'password123')
      expect(User.authenticate(email: 'test@example.com', password: 'wrongpassword')).to be_nil
    end
  end

end