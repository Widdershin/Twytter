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

    current_path.should eq '/profile'

    fill_in 'twyt', :with => 'The toilet sure is lonely...'
    click_button 'Post!'

    current_path.should eq "/twyt"
  end



end
