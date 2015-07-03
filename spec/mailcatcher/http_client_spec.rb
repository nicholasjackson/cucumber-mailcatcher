require_relative '../../lib/cucumber/mailcatcher/http_client'

describe Cucumber::Mailcatcher::HttpClient do

  let(:server) {"http://localhost"}

  before(:each) do
    subject.server_url = server

    stub_request(:get, "#{server}/messages").to_return(
      :status => 200,
      :body => JSON.load(File.open('./spec/test_json/messages.json')),
      :headers => {}
    )

    stub_request(:delete, "http://localhost/messages").to_return(
      :status => 204
    )
  end

  it "should return two messages when get_messages is called" do
    messages = subject.get_messages

    expect(WebMock).to have_requested(:get,"#{server}/messages").once
    expect(messages.length).to be 2
  end

  it "should delete two messages when delete_messages is called" do
    deleted = subject.delete_messages

    expect(WebMock).to have_requested(:delete,"#{server}/messages").once
    expect(deleted).to be true
  end

end
