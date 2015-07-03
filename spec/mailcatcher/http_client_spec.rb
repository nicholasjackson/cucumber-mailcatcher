require_relative '../../lib/cucumber/mailcatcher/http_client'

describe Cucumber::Mailcatcher::HttpClient do

  before(:each) do
    server = "http://localhost"
    subject.server_url = server

    stub_request(:get, "#{server}/messages").to_return(
      :status => 200,
      :body => JSON.load(File.open('./spec/test_json/messages.json')),
      :headers => {}
    )
  end

  it "should return two messages when get_messages is called" do
    expect(subject.get_messages.length).to be 2
  end

end
