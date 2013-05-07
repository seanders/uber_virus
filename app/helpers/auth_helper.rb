
helpers do
  def client
    @client ||= OAuth2::Client.new(ENV["GOOGLE_API_CLIENT"], ENV["GOOGLE_API_SECRET"], {
      :site => 'https://accounts.google.com', 
      :authorize_url => "/o/oauth2/auth", 
      :token_url => "/o/oauth2/token"
      })
  end
end
