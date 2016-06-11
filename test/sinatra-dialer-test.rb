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

  def test_it_retrieves_image_results
    get '/'
    assert last_response.ok?
    assert_equal 'Hello World', last_response.body
  end

  def test_it_sends_a_message
    get '/', :name => 'Simon'
    assert last_response.body.include?('Simon')
  end

end