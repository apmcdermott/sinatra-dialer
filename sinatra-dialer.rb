get '/' do

  erb :index
  
end

post '/' do

  search_term = params['search_term']

  uri = URI.parse("http://api.giphy.com/v1/gifs/search?q=" + search_term + "&api_key=dc6zaTOxFJmzC")

  response = Net::HTTP.get_response(uri)

  parsed_response = JSON.parse(response.body)

  number_of_results = parsed_response["pagination"]["count"].to_i

  results = parsed_response["data"]

  #Select randomly from resuls
  number = Random.new.rand(number_of_results).to_i

  selected_result = results[number]

  @image_url = selected_result["images"]["fixed_height"]["url"]

  # put your own credentials here 
  account_sid = 'AC0cdeecfe4679db365c25a166f5ebfcf9' 
  auth_token = '5c9219d5798ed86241acbd198bb0331b' 
   
  # set up a client to talk to the Twilio REST API 
  @client = Twilio::REST::Client.new account_sid, auth_token 
   
  @message_result = @client.account.messages.create({
    :from => '+16179350712', 
    :to => '6179971870', 
    :body => "You searched for " + search_term,
    :media_url => @image_url
  })

  erb :create

end