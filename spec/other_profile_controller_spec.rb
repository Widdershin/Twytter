require 'spec_helper'

describe 'The controller for other users profiles' do

  before do
    User.delete_all
    @other_user = User.make(username: 'other_test_user', email: 'foo@bar.com', password: 'test')
    @message = "my great message"
    @other_user.post_twyt(@message)
    visit '/profile/other_test_user'
  end

  it 'shows you their username' do
    expect(page).to have_content(@other_user.username)
  end

  it 'shows you their twyts' do
    expect(page).to have_content(@message)
  end

  describe 'when logged in it' do
    before do
      @user = User.make(username: 'test_user', email: 'foo@snaz.net', password: 'test')
      login('test_user', 'test')
    end

    it 'lets you follow them' do
      visit '/profile/other_test_user'
      click_button 'Follow'

      expect(@user.follows_users).to include(@other_user)
    end

    it 'does not let you follow them twice' do
      @user.follow(@other_user)
      visit '/profile/other_test_user'
      click_button 'Follow'

      expect(page).to have_content('Error: you are already following this user')
    end

    it "doesn't let you view your profile as if you were someone else" do
      visit '/profile/test_user'

      expect(current_path).to eq '/profile'
    end
  end


end
