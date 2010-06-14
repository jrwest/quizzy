Given /^an account "([^"]*)" with password "([^"]*)"$/ do |account_name, password|
  Account.create(:name => account_name, :password => password, :confirm_password => password)
end

Then /^an account should exist with name "([^"]*)"$/ do |account_name|
  Account.where(:name => account_name).should_not be_empty
end

