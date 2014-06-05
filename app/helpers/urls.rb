helpers do
  def previous_url(request)
    request.referrer.gsub(request.base_url, "")
  end
end
