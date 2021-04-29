feature 'book space' do
  scenario 'user can book a space' do
    visit '/'
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
end