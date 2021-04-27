require 'space'

describe Space do
  describe '.create' do
    it 'lets user create a database entry' do
      name = '10 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = '$10.00'

      Space.create(name: name, description: description, price_per_night: price_per_night)
      result_from_db = DatabaseConnection.query('SELECT * FROM space;').first
      name_from_db = result_from_db['name']
      description_from_db = result_from_db['description']
      price_per_night_from_db = result_from_db['price_per_night']

      expect(name_from_db).to eq name
      expect(description_from_db).to eq description
      expect(price_per_night_from_db).to eq price_per_night
    end
  end

  context 'new instance' do
    it 'has 3 properties which are available' do
      name = '10 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = 10
      new_space = described_class.new(name: name, description: description, price_per_night: price_per_night)
      expect(new_space.name).to eq name
      expect(new_space.description).to eq description
      expect(new_space.price_per_night).to eq price_per_night
    end
  end

  describe '.all' do
    it 'pulls records from the database' do
      name = '10 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = '$10.00'

      described_class.create(name: name, description: description, price_per_night: price_per_night)
      space_from_db = described_class.all

      expect(space_from_db.name).to eq name
      expect(space_from_db.description).to eq description
      expect(space_from_db.price_per_night).to eq price_per_night
    end
  end

  describe '.update_availibility' do
    it 'updates the availibility' do
      name = '10 makers lane'
      description = 'this is a 1 bedroom apartment'
      price_per_night = '$10.00'
      described_class.create(name: name, description: description, price_per_night: price_per_night)

      described_class.update(name: name)

      result_from_db = DatabaseConnection.query('SELECT availibility FROM space;').first
      expect(result_from_db['availibility']).to eq 'f'
    end
  end
end
