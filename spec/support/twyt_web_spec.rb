require 'spec_helper'

describe "Twyts web interaction" do
  before do
    @user = User.make(username: 'test', email: 'test@bar.com', password: 'bar')
    @other_user = User.make(username: 'other_test', email: 'o@o.net', password: 'snaz')
    login('test', 'bar')
  end

  it 'lets you retweet' do
    @user.follow(@other_user)
    @other_user.post_twyt("Wow such test")

    visit '/'

    click_button 'Retweet'

    expect(page).to have_content('RT @other_test: Wow such test')
  end
end
