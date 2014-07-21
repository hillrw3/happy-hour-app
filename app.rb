require "sinatra"
require "active_record"
require "rack-flash"
require "yelp"
require "gschool_database_connection"
require "faraday"
require "json"
require_relative "lib/users_table"


class App <Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @client = Yelp::Client.new(:consumer_key    => '2C6rgKhf0AD8oMvkSxkeMA',
                   :consumer_secret => 'd_G_9y--T3Zo3xZBmCHsBAxlHvU',
                   :token           => 'twcpJoSxXdafBrAXUwyJjQ-RWEOEgJcH',
                   :token_secret    => '0P4Q5MUWLRK85lGm0CneI5K01pg')
    @users_table = UsersTable.new(
      GschoolDatabaseConnection::DatabaseConnection.establish(ENV["RACK_ENV"])
    )
  end

  get '/' do
    erb :root
  end

  get '/map' do
    erb :map
  end

  get '/registration' do
    erb :registration
  end

  post '/registration' do
    if params[:username] == '' && params[:password] == ''
      flash[:error_flash] = "Username and password are required"
      redirect "/registration"
    elsif params[:password] == ''
      flash[:error_flash] = "Password is required"
      redirect "/registration"
    elsif params[:username] == ''
      flash[:error_flash] = "Username is required"
      redirect "/registration"
    elsif params[:email] == ''
      flash[:error_flash] = "Email address is required"
      redirect "/registration"
    elsif params[:password] != params[:pass_confirm]
      flash[:error_flash] = "Passwords don't match!"
      redirect "/registration"
    else
      if @users_table.find_id_by_name(params[:username]) != nil
        flash[:error_flash] = "Username is already in use, please choose another."
        redirect "/registration"
      end
      flash[:notice] = "Thanks for registering!"
      @users_table.create(params[:username], params[:email], params[:password])
      redirect "/"
    end
  end

  get '/sign_in' do
    erb :sign_in
  end

  post '/sign_in' do
    username = params[:username]
    password = params[:password]
    user = @users_table.find_by(username, password)
    if user != nil
      user_id = user["id"]
      session[:user] = user_id
      flash[:notice] = "Hello again, #{username}!"
      redirect '/'
    else
      flash[:error_flash] = "Username and password not found"
      redirect back
    end
  end

  get '/sign_out' do
    session.clear
    redirect back
  end

end