require "sinatra"
require "active_record"
require "rack-flash"
require "yelp"
require "gschool_database_connection"
require "faraday"
require "json"


class App <Sinatra::Application
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @client = Yelp::Client.new(:consumer_key    => '2C6rgKhf0AD8oMvkSxkeMA',
                   :consumer_secret => 'd_G_9y--T3Zo3xZBmCHsBAxlHvU',
                   :token           => 'twcpJoSxXdafBrAXUwyJjQ-RWEOEgJcH',
                   :token_secret    => '0P4Q5MUWLRK85lGm0CneI5K01pg')

  end

  get '/' do
    erb :root
  end

end