require_relative '../../lib/cucumber/mailcatcher/http_client'

describe Cucumber::Mailcatcher::HttpClient do

  let(:server) {"http://localhost"}

  before(:each) do
    subject.server_url = server

    stub_request(:get, "#{server}/messages").to_return(
      :status => 200,
      :body => File.open('./spec/test_json/messages.json'),
      :headers => {}
    )

    stub_request(:delete, "http://localhost/messages").to_return(
      :status => 204
    )

    stub_request(:get, "http://localhost/messages/1.json.html").to_return(
      :status => 200,
      :body => File.open('./spec/test_json/message.html'),
      :headers => {}
    )

    stub_request(:get, "http://localhost/messages/2.json.html").to_return(
      :status => 404,
      :headers => {}
    )

    stub_request(:get, "http://localhost/messages/3.json.html").to_return(
      :status => 404,
      :headers => {}
    )

    stub_request(:get, "http://localhost/messages/1.json.plain").to_return(
      :status => 200,
      :body => File.open('./spec/test_json/message.txt'),
      :headers => {}
    )

    stub_request(:get, "http://localhost/messages/2.json.plain").to_return(
      :status => 404,
      :headers => {}
    )

    stub_request(:get, "http://localhost/messages/3.json.plain").to_return(
      :status => 404,
      :headers => {}
    )
  end

  it "should return two messages when get_messages is called" do
    messages = subject.get_messages

    expect(WebMock).to have_requested(:get,"#{server}/messages").once
    expect(messages.length).to be 3
  end

  it "should delete two messages" do
    deleted = subject.delete_messages

    expect(WebMock).to have_requested(:delete,"#{server}/messages").once
    expect(deleted).to be true
  end

  it 'should return one message with from email test1@demo.gs' do
    messages = subject.get_messages_from_email 'test1@demo.gs'
    expect(messages.length).to be 1
  end

  it 'should return two messages to email nic@thatlondon.com' do
    messages = subject.get_messages_to_email 'nic@thatlondon.com'
    expect(messages.length).to be 2
  end

  it 'should return two messages with subject Your password reset reminder' do
    messages = subject.get_messages_with_subject 'Your password reset reminder'
    expect(messages.length).to be 2
  end

  it 'should return one message with html body containing link' do
    messages = subject.get_messages_with_html_body '<a href='
    expect(messages.length).to be 1
  end

  it 'should return one message with plain body containing link' do
    messages = subject.get_messages_with_plain_body 'http://mysite.com'
    expect(messages.length).to be 1
  end

end
