require 'spec_helper'

describe User do

  before do
    User.delete_all
    @user = User.create(username: 'TestUser', email: 'test@example.com' )
    @user.set_password('welcome')
    @user.save
  end

  it 'can authenticate login attempts' do
    expect(User.authenticate('TestUser', 'welcome')).to eq(@user.id)
  end

  it 'rejects invalid login attempts' do
    expect(User.authenticate('TestUser', 'wrongpass')).to be_nil
  end

  it 'ensures usernames are unique' do
    new_user = User.create(username: @user.username, email: "foo@bar.com")
    expect(new_user.valid?).to be_false
  end
end
