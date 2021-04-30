
def sign_up
  visit '/'
  click_button 'Sign up'
  fill_in 'user_name', with: 'bojo'
  fill_in 'email', with: 'bojo10@downingstreet.com'
  fill_in 'password', with: 'bjohnson'
  click_button 'Sign up'
end

def sign_in
  visit '/'
  click_button 'Sign in'
  fill_in 'email', with: 'bojo10@downingstreet.com'
  fill_in 'password', with: 'bjohnson'
  click_button 'Sign in'
end


def sign_out
  click_button 'Sign out'
end

def become_a_host
  sign_up
  click_button 'Become a host'
  expect(current_path).to eq '/space/new'
  fill_in 'name', with: '10 Downing street'
  fill_in 'description', with: 'Lovely gaff'
  fill_in 'price_per_night', with: '100000'
  click_button 'Host'
end

