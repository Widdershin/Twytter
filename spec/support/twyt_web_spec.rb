require 'spec_helper'

describe "Twyts web interaction" do
  before do
    User.delete_all
    Twyt.delete_all

    @user = User.make(username: 'test', email: 'test@bar.com', password: 'bar')
    @other_user = User.make(username: 'other_test', email: 'o@o.net', password: 'snaz')
    login('test', 'bar')

    @user.follow(@other_user)
    @other_user.post_twyt("Wow such test")
  end

  it 'lets you retweet' do
    visit '/'

    click_button 'Retweet'

    expect(page).to have_content('RT @other_test: Wow such test')
  end

  it 'lets you favourite a twyt' do
    visit '/'

    click_button 'Favourite'

    expect(page).to have_content('Added twyt to favourites!')
    expect(current_path).to eq '/'
    expect(@user.favourites.last.message).to eq 'Wow such test'
  end

  it "doesn't let you favourite a twyt twice" do
    visit '/'

    click_button 'Favourite'
    click_button 'Favourite'

    expect(page).to have_content('Error: You already favourited this twyt')
  end
end
