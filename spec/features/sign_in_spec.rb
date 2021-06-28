feature 'Sign in' do
  scenario 'A user can sign in' do
    visit '/'
    click_button 'Sign up'
    expect(current_path).to eq '/user/new'
    fill_in 'user_name', with: 'bojo'
    fill_in 'email', with: 'bojo10@downingstreet.com'
    fill_in 'password', with: 'bjohnson'
    click_button 'Sign up'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Welcome BOJO'
    click_button 'Sign out'
    expect(current_path).to eq '/'
    expect(page).not_to have_content 'Welcome BOJO'

    click_button 'Sign in'
    fill_in 'email', with: 'bojo10@downingstreet.com'
    fill_in 'password', with: 'bjohnson'
    click_button 'Sign in'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Welcome BOJO'
  end
end
