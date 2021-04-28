feature 'Homepage' do
  scenario 'A user can see a welcome message' do
    visit '/'
    expect(page).to have_content 'Welcome to MakersBnB'
    click_button 'Become a host'
    expect(current_path).to eq '/space/new'
    fill_in 'name', with: '10 Downing street'
    fill_in 'description', with: 'Lovely gaff'
    fill_in 'price_per_night', with: '100000'
    click_button 'Host'
    expect(current_path).to eq '/'
    expect(page).to have_content '10 Downing street'
    expect(page).to have_content 'Lovely gaff'
    expect(page).to have_content '$100,000.00 per night'
  end
end

feature 'Become a host button' do
  scenario 'A user can become a host' do
    visit '/'
    click_button 'Become a host'
    expect(current_path).to eq '/space/new'
  end
end

feature 'Sign-up button' do
  scenario 'A user can click button to sign up' do
    visit '/'
    click_button 'Sign up'
    expect(current_path).to eq '/user/new'
  end
end
