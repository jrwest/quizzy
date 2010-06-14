Given /^no quizzes exist$/ do
  Quiz.delete_all
end

Given /^a quiz "([^"]*)"$/ do |quiz_name|
  Quiz.create(:name => quiz_name)
end

Given /^a quiz "([^"]*)" with author "([^"]*)"$/ do |quiz_name, author|
  Quiz.create(:name => quiz_name, :author => author)
end

Given /^the quizzes:$/ do |quizzes|
  quizzes.hashes.each do |quiz|
    Given "a quiz \"#{quiz['name']}\""
  end
end

Then /^a quiz with name "([^"]*)" and author "([^"]*)" should exist$/ do |quiz_name, quiz_author|
  Quiz.where(:name => quiz_name, :author => quiz_author).should_not be_empty
end
