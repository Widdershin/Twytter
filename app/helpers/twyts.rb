helpers do
  def render_twyts(twyt_list)
    twyt_list.map { |twyt| render_twyt(twyt) }.join
  end

  def render_twyt(twyt)
  <<-HTML
  Username: #{twyt.user} <br>
  Message: #{twyt.message} <br>
  <form action='/twyt' method='post'>
    <input type='hidden' name='twyt' value='RT @#{ twyt.user }: #{ twyt.message }'>
    <input type='submit' value='Retweet'>
  </form>

  <form action='/favourite' method='post'>
    <input type='hidden' name='twyt_id' value='#{ twyt.id }'>
    <input type='submit' value='Favourite'>
  </form><br>
  HTML
  end
end
