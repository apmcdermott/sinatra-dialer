get '/' do

  erb :index
  
end

post '/' do

  # put your own credentials here 
  account_sid = 'AC0cdeecfe4679db365c25a166f5ebfcf9' 
  auth_token = '5c9219d5798ed86241acbd198bb0331b' 
   
  # set up a client to talk to the Twilio REST API 
  @client = Twilio::REST::Client.new account_sid, auth_token 
   
  @client.account.messages.create({
    :from => '+16179350712', 
    :to => '6179971870', 
    :body => 'hello',  
  })
  
  erb :create

end