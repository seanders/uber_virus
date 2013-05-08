get '/' do
  client
  erb :index
end


get "/login" do
  redirect client.auth_code.authorize_url(:redirect_uri => 'http://localhost:9393/oauth2callback', :scope => "https://www.googleapis.com/auth/plus.login")
end

get "/oauth2callback" do
  token = client.auth_code.get_token(
    params[:code],
    :redirect_uri => 'http://localhost:9393/oauth2callback'
    )
  response = token.get 'https://www.googleapis.com/oauth2/v1/userinfo?alt=json'
  user_info = JSON.parse(response.body)
  user_token = token.token
  p user_info
  @user = User.find_or_create_by_google_id(:google_id => user_info['id'])
  @user.google_token = user_token
  @user.save
  session[:id] = @user.id
redirect "/profile"
end

get "/profile" do
  @user = User.find(session[:id])
  p @user
   GooglePlus.access_token = @user.google_token
  @person = GooglePlus::Person.get(@user.google_id)
  p @person
  erb :profile
end


get "/signout" do
  session.clear
  redirect "/"
end