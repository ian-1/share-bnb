feature 'Sign up' do
  scenario 'A user can fill in a sign up form' do
    visit '/'
    click_button 'Sign up'
    expect(current_path).to eq '/user/new'
    fill_in 'user_name', with: 'bojo'
    fill_in 'email', with: 'bojo10@downingstreet.com'
    fill_in 'password', with: 'bjohnson'
    click_button 'Sign up'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Welcome BOJO'
    expect(current_path).to eq '/'
  end
end
