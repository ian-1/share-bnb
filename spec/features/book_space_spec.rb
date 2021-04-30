feature 'book space' do
  scenario 'signed in user can book a space' do
    become_a_host
    expect(current_path).to eq '/'
    click_button 'Book'
    expect(current_path).to eq '/'
    expect(page).not_to have_content '10 Downing street'
  end

  scenario 'non signed in user can not book a space' do
    become_a_host
    click_button 'Sign out'
    expect(current_path).to eq '/'
    click_button 'Book'
    expect(page).to have_content '10 Downing street'
    expect(page).to have_content 'Please sign in/sign up to book a property'
  end
end