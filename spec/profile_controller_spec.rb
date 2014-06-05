require 'spec_helper'

describe "Profile controller" do
  before do
    @user = User.make(username: 'test_user', email: 'foo@bar.com', password: 'test')
    visit '/'

    fill_in 'username', :with => "test_user"
    fill_in 'password', :with => "test"
    click_button 'Login'
  end

  it 'lets you write and post a twyt' do

    visit '/profile'

    fill_in 'twyt', :with => 'The toilet sure is lonely...'
    click_button 'Post!'

    expect(page).to have_content 'The toilet sure is lonely...'
  end

  it "displays an error message if you try and make a twyt over 140 characters" do

    visit '/profile'

    fill_in 'twyt', :with => 'a' * 150
    click_button 'Post!'

    expect(page).to have_content 'Error: Twyts must be 140 characters or less.'
  end
end
