require_relative '../../lib/cucumber/mailcatcher/http_client'

describe Cucumber::Mailcatcher::HttpClient do
  it "should raise an exception when url is nil" do
    Cucumber::Mailcatcher::HttpClient.server_url = nil

    expect { Cucumber::Mailcatcher::HttpClient.new }.
      to raise_error("Please set the Mailcatcher server url e.g. Cucumber::Mailcatcher::HttpClient.server_url = 'http://localhost:1080'")
  end

  it "should raise an exception when url is not a valid url" do
    Cucumber::Mailcatcher::HttpClient.server_url = 'httpss'

    expect { Cucumber::Mailcatcher::HttpClient.new }.
      to raise_error("Please set the Mailcatcher server url e.g. Cucumber::Mailcatcher::HttpClient.server_url = 'http://localhost:1080'")
  end

  it "should not raise an exception when url is valid url" do
    Cucumber::Mailcatcher::HttpClient.server_url = 'https://localhost:2131/'

    expect { Cucumber::Mailcatcher::HttpClient.new }.
      to_not raise_error
  end
end

describe Cucumber::Mailcatcher::HttpClient do
  subject(:http) {
    Cucumber::Mailcatcher::HttpClient.server_url = 'http://localhost'
    Cucumber::Mailcatcher::HttpClient.new
  }

  before(:each) do
    stub_request(:get, "http://localhost/messages").to_return(
      :status => 200,
      :body => File.open('./spec/test_json/messages.json'),
      :headers => {}
    )

    stub_request(:delete, "http://localhost/messages").to_return(
      :status => 204
    )
  end

  it 'should request url when do_get called' do
    http.do_get '/messages'
    expect(WebMock).to have_requested(:get,"http://localhost/messages").once
  end

  it 'should request url when do_get called and return response' do
    response = http.do_get '/messages'

    expect(response.code).to eq '200'
  end

  it 'should return json when do_get_json is called' do
    messages = http.do_get_json '/messages'

    expect(messages.length).to be 3
  end

  it 'should call url when do_delete is called' do
    messages = http.do_delete '/messages'

    expect(WebMock).to have_requested(:delete,"http://localhost/messages").once
  end
end
