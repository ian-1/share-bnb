require 'space'

describe Space do

  describe '.create' do
    it 'lets user create a database entry' do
      space_1 = "space_1"
      Space.create(name: space_1)
      result_from_db = DatabaseConnection.query("SELECT name FROM space ").first
      space_1_from_db = result_from_db['name']
      expect(space_1_from_db).to eq space_1
    end
  end

  context 'new instance' do
    it 'has 3 properties which are available' do
      name = "10 makers lane"
      description = "this is a 1 bedroom apartment"
      price_per_night = 10
      new_space = described_class.new(name: name, description: description, price_per_night: price_per_night)
      expect(new_space.name).to eq name
      expect(new_space.description).to eq description
      expect(new_space.price_per_night).to eq price_per_night
    end
  end
end
