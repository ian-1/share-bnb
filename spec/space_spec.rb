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
end
