Then /^an account should exist with name "([^"]*)"$/ do |account_name|
  Account.where(:name => account_name).should_not be_empty
end
