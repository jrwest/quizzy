Given /^an account "([^"]*)" with password "([^"]*)"$/ do |account_name, password|
  Account.create(:name => account_name, :password => password, :confirm_password => password)
end

# this is pretty much a hack because testing 
# sessions with cucumber and sinatra is a big, big, almost impossible pain
Given /^an unauthorized account$/ do
  visit '/logout'
end

Given /^the account "([^"]*)" with password "([^"]*)" is authorized$/ do |account_name, password|
  visit '/login'
  fill_in "username", :with => account_name
  fill_in "password", :with => password
  click_button "Log In"
end

Then /^an account should exist with name "([^"]*)"$/ do |account_name|
  Account.where(:name => account_name).should_not be_empty
end

