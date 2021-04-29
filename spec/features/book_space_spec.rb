feature 'book space' do
  scenario 'signed in user can book a space' do
    visit '/'
    click_button 'Sign up'
    expect(current_path).to eq '/user/new'
    fill_in 'user_name', with: 'bojo'
    fill_in 'email', with: 'bojo10@downingstreet.com'
    fill_in 'password', with: 'bjohnson'
    click_button 'Sign up'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Welcome bojo'

    click_button 'Become a host'
    expect(current_path).to eq '/space/new'
    fill_in 'name', with: '10 Downing street'
    fill_in 'description', with: 'Lovely gaff'
    fill_in 'price_per_night', with: '100000'
    click_button 'Host'
    expect(current_path).to eq '/'

    click_button 'Book'

    expect(current_path).to eq '/'

    expect(page).not_to have_content '10 Downing street'
  end

  scenario 'non signed in user can not book a space' do
    visit '/'
    click_button 'Become a host'
    expect(current_path).to eq '/space/new'
    fill_in 'name', with: '10 Downing street'
    fill_in 'description', with: 'Lovely gaff'
    fill_in 'price_per_night', with: '100000'
    click_button 'Host'
    expect(current_path).to eq '/'

    click_button 'Book'
    expect(page).to have_content '10 Downing street'
    expect(page).to have_content 'Please sign in/sign up to book a property'
  end
end