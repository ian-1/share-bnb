require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')

  # Clear the test table(s)
  connection.exec('TRUNCATE space, app_user;')
end
