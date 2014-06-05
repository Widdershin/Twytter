require 'spec_helper'

describe 'The controller for other users profiles' do

  before do
    User.delete_all
    @user = User.make(username: 'test_user', email: 'foo@bar.com', password: 'test')
    @message = "my great message"
    @user.post_twyt(@message)
    visit '/profile/test_user'
  end

  it 'shows you their username' do
    expect(page).to have_content(@user.username)
  end

  it 'shows you their twyts' do
    expect(page).to have_content(@message)
  end
end
