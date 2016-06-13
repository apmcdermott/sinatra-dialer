require File.expand_path '../test_helper.rb', __FILE__

class SinatraDialerTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_loads_search_page
    get '/'
    assert last_response.ok?
    last_response.body.include?('Image Search Term')
  end

  def test_it_handles_blank_values
    get '/'
    assert last_response.ok?
    last_response.body.include?('Image Search Term')
  end

  def test_it_retrieves_image_results
    post '/', :search_term => 'Simon'
    assert last_response.ok?
    last_response.body.include?('Image URL used: http:')
  end

  def test_it_sends_a_message
    post '/', :search_term => 'Simon'
    assert last_response.body.include?('Message Sending Result Status: queued')
  end

end