require 'spec_helper'

describe "Profile controller" do
  before do
    User.delete_all
    @user = User.make(username: 'test_user', email: 'foo@bar.com', password: 'test')

    login('test_user', 'test')

    visit '/profile'
  end

  it 'lets you write and post a twyt' do
    fill_in 'twyt', :with => 'The toilet sure is lonely...'
    click_button 'Post!'

    expect(page).to have_content 'The toilet sure is lonely...'
  end

  it "displays an error message if you try and make a twyt over 140 characters" do
    fill_in 'twyt', :with => 'a' * 150
    click_button 'Post!'

    expect(page).to have_content 'Error: Twyts must be 140 characters or less.'
  end

  it 'lets you logout' do
    click_link 'Logout'

    expect(current_path).to eq '/'
  end

  it 'displays your favourite twyts' do
    other_user = User.create(username: 'other_user')
    twyt = other_user.post_twyt('Best twyt ever')
    @user.favourite(twyt)

    visit '/profile'

    expect(page).to have_content 'Favourites'
    expect(page).to have_content twyt.message
  end
end
