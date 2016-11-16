require 'sinatra'
require 'json'
require 'httparty'

set :port, 8080
set :environment, :production

tempOrders = Array.new # TODO Redis cache for orders
uniqueId = 0 # TODO Better unique id
displays = Array.new # Todo use the displays instance to notify them

get '/orders' do
  content_type :json
  # get current orders for all Eable menus
  
  return tempOrders.to_json.to_s
end

post '/orders/:tablet_id' do
  content_type :json

  body = JSON.parse(request.body.read)
  puts 'body', body
  results = Hash.new
  id = params[:tablet_id]
  title = body['title']
  cost = body['cost']
  
  # TODO Cross match article prices with active menu

  puts "Tablet #{id} ordered #{title} for #{cost}" 
  tempOrders.push({ unique_id: uniqueId, tablet_id: id, title: title, cost: cost })
  uniqueId += 1
  
  response = HTTParty.get('http://127.0.0.1:9090/notify')

  # TODO Make request to the displays OR notify them a change has occured
  results[:status] = 'success'
  results[:average_time] = '12 minutes'

  return results.to_json
end
