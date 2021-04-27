feature 'Homepage' do
  scenario 'A user can see a welcome message' do
    visit '/'
    expect(page).to have_content 'Welcome to MakersBnB'
  end
  
end