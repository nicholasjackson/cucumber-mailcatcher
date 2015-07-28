# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber/mailcatcher/version"

Gem::Specification.new do |s|
  s.name        = Cucumber::Mailcatcher::NAME
  s.version     = Cucumber::Mailcatcher::VERSION
  s.date        = '2015-07-25'
  s.summary     = "Cucumber steps for Mailcatcher mock SMTP server"
  s.description = "Some simple cucumber steps to allow behavioural testing with the Mailcatcher mock SMTP server"
  s.authors     = ["Nic Jackson"]
  s.email       = 'jackson.nic@gmail.com'
  s.files       = [
    'lib/cucumber/mailcatcher.rb',
    'lib/cucumber/mailcatcher/http_client.rb',
    'lib/cucumber/mailcatcher/api.rb',
    'lib/cucumber/mailcatcher/version.rb'
  ]
  s.homepage    =
    'https://github.com/nicholasjackson/cucumber-mailcatcher'
  s.license       = 'MIT'
  s.add_runtime_dependency 'cucumber', '~> 1.3', '>= 1.3.10'
  s.add_runtime_dependency 'rspec-expectations', '~> 3.3', '>= 3.3.1'
end
