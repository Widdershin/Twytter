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
end
