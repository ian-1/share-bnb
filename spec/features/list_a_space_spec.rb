feature 'Become a host' do
  scenario 'A user can become a host' do
    become_a_host
    expect(page).to have_content '10 Downing street'
    expect(page).to have_content 'Lovely gaff'
    expect(page).to have_content '$100,000.00'
  end

  scenario 'A user can list multiple spaces' do
    become_a_host
    click_button 'Become a host'
    expect(current_path).to eq '/space/new'
    fill_in 'name', with: '11 Downing street'
    fill_in 'description', with: 'Lovely elephant'
    fill_in 'price_per_night', with: '10'
    click_button 'Host'
    expect(current_path).to eq '/'

    expect(page).to have_content '10 Downing street'
    expect(page).to have_content 'Lovely gaff'
    expect(page).to have_content '$100,000.00'

    expect(page).to have_content '11 Downing street'
    expect(page).to have_content 'Lovely elephant'
    expect(page).to have_content '$10.00'

  end
end
