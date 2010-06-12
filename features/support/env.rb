# Generated by cucumber-sinatra. (Fri Jun 11 23:34:14 -0400 2010)

require File.join(File.dirname(__FILE__), '..', '..', 'quizzy.rb')

require 'capybara'
require 'capybara/cucumber'
require 'spec'

Sinatra::Application.set(:environment, :test)

World do
  Capybara.app = Sinatra::Application
  include Capybara
  include Spec::Expectations
  include Spec::Matchers
end

Before do
  Mongoid.database.collections.each(&:drop)
end
