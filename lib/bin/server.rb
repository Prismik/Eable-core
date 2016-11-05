require 'sinatra'
require 'json'

set :port, 8080
set :environment, :production

get '/orders' do
  content_type :json
  results = { }
  # get current orders for all Eable menus

  return results.to_json
end

