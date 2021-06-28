require 'booking'
require 'user'
require 'space'

describe Booking do
  let(:user) {User.create(name: "John" , email: "jman@user.com", password: "password123")}
  let(:space) {Space.create(name: "10 Makers Lane", description: "Nice house", price_per_night: "10", user_id: user.id) }
  let(:booking) { Booking.create(start_date: "1/05/2021", end_date: "02/05/2021", user_id: "#{user.id}", space_id: space.id) }

  describe '.create' do
    it 'creates a new booking' do
      user
      space
      booking

      result = DatabaseConnection.query('SELECT * FROM booking;').first
      expect(result['start_date']).to eq("2021-01-05")
      expect(booking.start_date).to eq("#{result['start_date']}")
      expect(booking.end_date).to eq("#{result['end_date']}")
      expect(booking.user_id).to eq("#{result['user_id']}")
      expect(booking.space_id).to eq("#{result['space_id']}")
    end
  end
end