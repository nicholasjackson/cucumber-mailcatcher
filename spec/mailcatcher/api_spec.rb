require_relative '../../lib/cucumber/mailcatcher/api'

describe Cucumber::Mailcatcher::Api do
  let(:http_client) { double('http_client') }

  before(:each) {
    allow(http_client).to receive(:do_get_json).and_return(
      JSON.load(File.open('./spec/test_json/messages.json'))
    )

    allow(http_client).to receive(:do_get) {
      response = double('response')
      allow(response).to receive(:code).and_return(200)
      allow(response).to receive(:body).and_return("some stuff")
      response
    }

    allow(http_client).to receive(:do_get).with('/messages/2.json.html') {
      response = double('response')
      allow(response).to receive(:code).and_return(200)
      allow(response).to receive(:body).and_return(File.open('./spec/test_json/message.html').read())
      response
    }

    allow(http_client).to receive(:do_get).with('/messages/2.json.plain') {
      response = double('response')
      allow(response).to receive(:code).and_return(200)
      allow(response).to receive(:body).and_return(File.open('./spec/test_json/message.txt').read())
      response
    }

    allow(http_client).to receive(:do_delete)
  }

  subject(:api) { Cucumber::Mailcatcher::Api.new http_client }

  it "should call do_get_json get_messages is called" do
    expect(http_client).to receive(:do_get_json).with('/messages').once

    messages = api.get_messages
  end

  it "should delete messages" do
    expect(http_client).to receive(:do_delete).with('/messages').once

    deleted = api.delete_messages
    expect(deleted).to be true
  end

  it 'should return one message with from email test1@demo.gs' do
    expect(http_client).to receive(:do_get_json).with('/messages').once

    messages = api.get_messages_from_email 'test1@demo.gs'
    expect(messages.length).to be 1
  end

  it 'should return two messages to email nic@thatlondon.com' do
    expect(http_client).to receive(:do_get_json).with('/messages').once

    messages = api.get_messages_to_email 'nic@thatlondon.com'
    expect(messages.length).to be 2
  end

  it 'should return two messages with subject Your password reset reminder' do
    expect(http_client).to receive(:do_get_json).with('/messages').once

    messages = api.get_messages_with_subject 'Your password reset reminder'
    expect(messages.length).to be 2
  end

  it 'should return one message with html body containing link' do
    expect(http_client).to receive(:do_get_json).with('/messages').once
    expect(http_client).to receive(:do_get).exactly(3).times

    messages = api.get_messages_with_html_body '<a href='
    expect(messages.length).to be 1
  end

  it 'should return one message with plain body containing link' do
    expect(http_client).to receive(:do_get_json).with('/messages').once
    expect(http_client).to receive(:do_get).exactly(3).times

    messages = api.get_messages_with_plain_body 'http://mysite.com'
    expect(messages.length).to be 1
  end
end
