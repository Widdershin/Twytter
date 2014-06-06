describe "Login controller" do
  before do
    User.delete_all
    @user = User.make(username: 'test_user', email: 'foo@bar.com', password: 'test')
    visit '/'
  end

  it 'should redirect you to the feed after you login' do
    login('test_user', 'test')

    expect(current_path).to eq '/'
    expect(page).to have_content "Feed"
  end


end
