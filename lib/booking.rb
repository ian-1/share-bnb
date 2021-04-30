require_relative 'user'
require_relative 'space'

class Booking
  attr_reader :id, :start_date, :end_date, :user_id, :space_id

  def initialize(id:, start_date:, end_date:, user_id:, space_id:)
    @id = id
    @start_date = start_date
    @end_date = end_date
    @user_id = user_id
    @space_id = space_id
  end

  def self.create(start_date:, end_date:, user_id:, space_id:)
    columns = 'start_date, end_date, user_id, space_id'
    values = "'#{start_date}', '#{end_date}', (SELECT id FROM app_user WHERE id = '#{user_id}'), (SELECT id FROM space WHERE id = '#{space_id}')"
    result = DatabaseConnection.query("INSERT INTO booking (#{columns}) VALUES (#{values}) RETURNING * ;").first
    booking = Booking.new(id: result['id'], start_date: result["start_date"], end_date: result["end_date"], user_id: result["user_id"], space_id: result["space_id"])
  end  
end