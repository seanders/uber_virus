get '/' do
  client
  erb :index
end


get "/login" do
redirect client.auth_code.authorize_url(:redirect_uri => 'http://localhost:9393/oauth2callback', :scope => "https://www.googleapis.com/auth/plus.login")
end

get "/oauth2callback" do
  p params
  p "this was a get"

  token = client.auth_code.get_token(
    params[:code],
    :redirect_uri => 'http://localhost:9393/oauth2callback'
  )
  response = token.get 'https://www.googleapis.com/oauth2/v1/userinfo?alt=json'
  user_info = JSON.parse(response.body)
  p response
  p user_info
end