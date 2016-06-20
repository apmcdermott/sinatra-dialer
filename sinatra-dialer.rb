get '/' do
  erb :index
end

post '/' do

  cell_number = params['cell_number']
  search_term = params['search_term']

  uri = URI.parse("http://api.giphy.com/v1/gifs/search?q=" + search_term + "&api_key=dc6zaTOxFJmzC")

  response = Net::HTTP.get_response(uri)

  parsed_response = JSON.parse(response.body)

  number_of_results = parsed_response["pagination"]["count"].to_i

  results = parsed_response["data"]

  #Select randomly from results
  if number_of_results == 0
    erb :no_results
  else

    number = Random.new.rand(number_of_results).to_i

    selected_result = results[number]

    @image_url = selected_result["images"]["fixed_height"]["url"]

    TWILIO_ACCOUNT_SID = ENV["TWILIO_ACCOUNT_SID"]
    TWILIO_AUTH_TOKEN = ENV["TWILIO_AUTH_TOKEN"]
    TWILIO_FROM_NUMBER = ENV["TWILIO_FROM_NUMBER"]
     
    # set up a client to talk to the Twilio REST API 
    @client = Twilio::REST::Client.new TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN 
     
    @message_result = @client.account.messages.create({
      :from => TWILIO_FROM_NUMBER, 
      :to => cell_number, 
      :body => "You searched for " + search_term,
      :media_url => @image_url
    })

    erb :create

  end

end