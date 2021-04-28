require 'space'

describe Space do
  context '#new' do
    it 'has 3 properties which are available' do
      id = '101'
      name = '10 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = 10
      available = true
      new_space = described_class.new(
        id: id, 
        name: name, 
        description: description, 
        price_per_night: price_per_night,
        available: available
        )
      expect(new_space.id).to eq id
      expect(new_space.name).to eq name
      expect(new_space.description).to eq description
      expect(new_space.price_per_night).to eq price_per_night
      expect(new_space.available).to eq available
    end
  end

  describe '#unavailible' do
    it 'changes the availibility to false' do
      name = '9 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = '$10.00'
      described_class.create(name: name, description: description, price_per_night: price_per_night)

      result = DatabaseConnection.query('SELECT * FROM space;').first
      space = Space.new(
        id: result['id'],
        name: result['name'],
        description: result['description'],
        price_per_night: result['price_per_night'],
        available: result['availibility']
        )
      expect(space.name).to eq '9 makers lane'
      expect(space.available).to eq 't'
      
      space.unavailable

      result = DatabaseConnection.query('SELECT * FROM space;').first
      expect(result['availibility']).to eq 'f'
    end
  end

  describe '.create' do
    it 'lets user create a database entry' do
      name = '10 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = '$10.00'

      Space.create(name: name, description: description, price_per_night: price_per_night)
      result = DatabaseConnection.query('SELECT * FROM space;').first

      expect(result['name']).to eq name
      expect(result['description']).to eq description
      expect(result['price_per_night']).to eq price_per_night
      # expect(result['available']).to eq 't'
    end
  end

  describe '.all' do
    it 'pulls records from the database' do
      id = '401'
      name = '10 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = '$10.00'


      described_class.create(
        name: name, 
        description: description, 
        price_per_night: price_per_night,
        )
      space_from_db = described_class.all.last

      expect(space_from_db.name).to eq name
      expect(space_from_db.description).to eq description
      expect(space_from_db.price_per_night).to eq price_per_night
    end
  end

  describe '.available_list' do
    it 'pulls records of available properties from the database' do
      name = '1 Unavailable St'
      description = 'blah blah'
      price_per_night = '$10.00'
      described_class.create(name: name, description: description, price_per_night: price_per_night)

      name = '1 Available St'
      description = 'blah blah'
      price_per_night = '$10.00'
      described_class.create(name: name, description: description, price_per_night: price_per_night)
      result = DatabaseConnection.query('SELECT * FROM space;').first
      expect(result['name']).to eq '1 Unavailable St'
     
      space = described_class.new(
      id: result['id'],
      name: result['name'],
      description: result['description'],
      price_per_night: result['price_per_night'],
      available: result['availibility'])

      space.unavailable
      list = described_class.available_list
      expect(list.first.name).to eq '1 Available St'
    end
  end
end
