require 'spec_helper'

describe "Feed controller" do
  before do
    User.delete_all
    @user = User.make(username: 'test_user', email: 'foo@bar.com', password: 'test')

    visit '/'

    fill_in 'username', :with => "test_user"
    fill_in 'password', :with => "test"
    click_button 'Login'
  end

  it 'shows you the feed page if you are logged in' do
    visit '/'

    expect(page).to have_content 'Feed'
  end

  it 'displays the twit messages of your followers' do
    followed_user = User.create(username: 'TestTarget', email: 'testtarget@example.com')
    @twyt1 = followed_user.post_twyt("test message 1")
    followed_user2 = User.create(username: 'TestTarget2', email: 'testtarget2@example.com')
    @twyt2 = followed_user2.post_twyt("test message 2")

    @user.follows_users << followed_user
    @user.follows_users << followed_user2

    visit '/'

    expect(page).to have_content @twyt1.message
    expect(page).to have_content @twyt2.message
    expect(page).to have_content followed_user.username
    expect(page).to have_content followed_user2.username
  end

  it 'has a twyt bar' do
    visit '/'

    fill_in 'twyt', :with => 'The toilet sure is lonely...'
    click_button 'Post!'

    expect(current_path).to eq '/'
  end

end
