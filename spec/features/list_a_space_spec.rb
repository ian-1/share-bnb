feature 'List a new space' do
  scenario 'A user can list a new space' do
    visit '/'
    click_button 'List a space'
    expect(current_path).to eq '/space/new'
    fill_in 'name', with: '10 Downing street'
    fill_in 'description', with: 'Lovely gaff'
    fill_in 'price_per_night', with: '100000'
    click_button 'List space'
    expect(current_path).to eq '/'
  end
end