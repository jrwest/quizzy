# Taken from the cucumber-rails project.

module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the Quizzes/  
      '/quizzes'
    when /Create Quiz/
      '/quizzes/create'
    when /quiz page for "([^"]+)"/
      quiz = Quiz.first(:conditions => {:name => $1})
      "/quizzes/view/#{quiz.to_param}"
    when /Create Question Page for "([^"]+)"/
      quiz = Quiz.first(:conditions => {:name => $1})
      "/quizzes/view/#{quiz.to_param}/nq"
    when /the Score/
      '/quizzes/score'
    when /Create New Account/
      '/accounts/create'
    when /Authorization/
      '/login'
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
