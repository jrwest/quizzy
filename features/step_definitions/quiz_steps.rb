Given /^no quizzes exist$/ do
  Quiz.delete_all
end

Given /^a quiz "([^"]*)"$/ do |quiz_name|
  Quiz.create(:name => quiz_name)
end

Given /^the quizzes:$/ do |quizzes|
  quizzes.hashes.each do |quiz|
    Given "a quiz \"#{quiz['name']}\""
  end
end
