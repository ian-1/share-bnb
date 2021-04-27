# require 'database_connection'

# describe DatabaseConnection do
#   describe '.setup' do
#     it 'sets up the connection to database through pg' do
#       allow(PG).to receive(:connect)

#       described_class.setup 'makersbnb_test'
#       expect(PG).to have_received(:connect).with(dbname: 'makersbnb_test')
#     end

#     it 'database connection is persistent' do
#       connection = described_class.setup 'makersbnb_test'

#       expect(described_class.connection).to eq connection
#     end
#   end

#   describe '.query' do
#     it 'executes a query' do
#       connection = described_class.setup('makersbnb')

#       allow(connection).to receive(:exec)

#       described_class.query('SELECT * FROM space;')
#       expect(connection).to have_received(:exec).with('SELECT * FROM space;')
#     end
#   end
# end
