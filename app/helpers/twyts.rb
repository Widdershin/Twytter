helpers do
  def render_twyts(twyt_list)
    twyt_list.map { |twyt| render_twyt(twyt) }.join
  end

  def render_twyt(twyt)
  <<-HTML
  @#{twyt.user.profile_link} - #{linkify_usernames(twyt.message)} <br>
  <form action='/twyt' method='post'>
    <input type='hidden' name='twyt' value='RT @#{ twyt.user }: #{ twyt.message }'>
    <input type='submit' value='Retweet'>
  </form>

  <form action='/favourite' method='post'>
    <input type='hidden' name='twyt_id' value='#{ twyt.id }'>
    <input type='submit' value='Favourite'>
  </form><br>

  <div class = 'feedtweet'>
    <div class = 'tweethead'>
      <div class = 'tweetuser'>
        From: <%= twyt.user %>
      </div>
    <div class = 'retweet'>
      <input type='submit' value='Retweet'>
    </div>

  </div>
    Message: <%=twyt.message%><br>
    <form action='/twyt' method='post'>
      <input type='hidden' name='twyt' value='RT @<%= twyt.user %>: <%= twyt.message %>'>
    </form><br>
  </div>
  HTML
  end

  def linkify_usernames(message)
    message.gsub(/@(\w+)/) { "@#{User.linkify_username($1)}" }
  end

end
