require 'jsonpath'
require 'nokogiri'

require 'cucumber'
require 'cucumber/formatter/unicode' # Remove this line if you don't want Cucumber Unicode support

require 'cucumber/mailcatcher/http_client'
require 'cucumber/mailcatcher/api'
require 'cucumber/mailcatcher/version'

Then /^I should receive (\d+) email from "(.*?)"$/ do |count, address|
  api = Cucumber::Mailcatcher::Api.new Cucumber::Mailcatcher::HttpClient.new
  messages = api.get_messages_from_email address
  expect(messages.length).to be count.to_i
end

Then /^I should receive (\d+) email sent to "(.*?)"$/ do |count, address|
  api = Cucumber::Mailcatcher::Api.new Cucumber::Mailcatcher::HttpClient.new
  messages = api.get_messages_to_email address
  expect(messages.length).to be count.to_i
end

Then /^I should receive (\d+) email with subject "(.*?)"$/ do |count, subject|
  api = Cucumber::Mailcatcher::Api.new Cucumber::Mailcatcher::HttpClient.new
  messages = api.get_messages_with_subject subject
  expect(messages.length).to be count.to_i
end

Then /^I should receive (\d+) email with a html body containing "(.*?)"$/ do |count, body|
  api = Cucumber::Mailcatcher::Api.new Cucumber::Mailcatcher::HttpClient.new
  messages = api.get_messages_with_html_body body
  expect(messages.length).to be count.to_i
end

Then /^I should receive (\d+) email with a plain body containing "(.*?)"$/ do |count, body|
  api = Cucumber::Mailcatcher::Api.new Cucumber::Mailcatcher::HttpClient.new
  messages = api.get_messages_with_plain_body body
  expect(messages.length).to be count.to_i
end
