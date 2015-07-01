# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber/mailcatcher/version"

Gem::Specification.new do |s|
  s.name        = Cucumber::Mailcatcher::NAME
  s.version     = Cucumber::Mailcatcher::VERSION
  s.date        = '2015-07-01'
  s.summary     = "Hola!"
  s.description = "A simple hello world gem"
  s.authors     = ["Nic Jackson"]
  s.email       = 'jackson.nic@gmail.com'
  s.files       = ["lib/cucumber/mailcatcher.rb"]
  s.homepage    =
    'https://github.com/nicholasjackson/cucumber-mailcatcher'
  s.license       = 'MIT'
end
