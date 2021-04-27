feature 'Homepage' do
  scenario 'A user can see a welcome message' do
    visit '/'
    expect(page).to have_content 'Welcome to MakersBnB'
  end
  
end

feature 'List a space button' do
  scenario 'A user can list a space' do
    visit '/'
    click_button 'List a space'
    expect(current_path).to eq '/space/new'
  end
end


