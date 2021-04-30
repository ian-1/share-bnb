feature 'book space' do
  scenario 'signed in user can book a space' do
    become_a_host
    expect(current_path).to eq '/'
    click_button 'Book'
    expect(current_path).to eq '/'
    expect(page).not_to have_content '10 DOWNING STREET'
  end
end