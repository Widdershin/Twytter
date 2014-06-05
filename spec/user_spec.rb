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

  it 'lets you post a new twyt' do
    twyt = @user.post_twyt("Damn the toilet is lonely...")

    expect(@user.twyts).to include twyt
  end

  describe '#twyts_following' do

    before do
      Twyt.delete_all

      followed_user = User.create(username: 'TestTarget', email: 'testtarget@example.com')
      @twyt1 = followed_user.post_twyt("test message 1")
      followed_user2 = User.create(username: 'TestTarget2', email: 'testtarget2@example.com')
      @twyt2 = followed_user2.post_twyt("test message 2")

      @user.follows_users << followed_user
      @user.follows_users << followed_user2
    end

    it 'gives a list of the twyts of followed users' do
      expect(@user.twyts_following).to include(@twyt1)
      expect(@user.twyts_following).to include(@twyt2)
    end

    it 'sorts the list of twyts of followed users most recent first' do
      expect(@user.twyts_following).to eq [@twyt2, @twyt1]
    end

  end
end
