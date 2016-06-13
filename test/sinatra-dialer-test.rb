require File.expand_path '../test_helper.rb', __FILE__

class SinatraDialerTest < MiniTest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def receiving_number
     "6179350712"
  end

  def test_it_loads_search_page
    get '/'
    assert last_response.ok?
    last_response.body.include?('Image Search Term')
  end

  def test_it_handles_blank_values
    post '/', :search_term => 'Simon', :cell_number => receiving_number
    assert last_response.ok?
    last_response.body.include?('No results found.')
  end

  def test_it_retrieves_image_results
    post '/', :search_term => 'Simon', :cell_number => receiving_number
    assert last_response.ok?
    last_response.body.include?('Image URL used: http:')
  end

  def test_it_sends_a_message
    post '/', :search_term => 'Simon', :cell_number => receiving_number
    assert last_response.body.include?('Message Sending Result Status: queued')
  end

end