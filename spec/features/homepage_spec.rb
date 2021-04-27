feature 'Homepage' do
  scenario 'A user can see a welcome message' do
    visit '/'
    expect(page).to have_content 'Welcome to MakersBnB'
    click_button 'List a space'
    expect(current_path).to eq '/space/new'
    fill_in 'name', with: '10 Downing street'
    fill_in 'description', with: 'Lovely gaff'
    fill_in 'price_per_night', with: '100000'
    click_button 'List space'
    expect(current_path).to eq '/'
    expect(page).to have_content '10 Downing street'
    expect(page).to have_content 'Lovely gaff'
    expect(page).to have_content '£100000 per night'
  end
end

feature 'List a space button' do
  scenario 'A user can list a space' do
    visit '/'
    click_button 'List a space'
    expect(current_path).to eq '/space/new'
  end
end


