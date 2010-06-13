current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)
$LOAD_PATH.unshift(File.join(current_dir, '..'))
$LOAD_PATH.unshift(File.join(current_dir, %w[.. models]))

require 'rubygems'
require 'mongoid'
require 'spec'

Mongoid.database = Mongo::Connection.new.db('quizzy_spec')

Spec::Runner.configure do |config|
  config.after do 
    Mongoid.database.collections.reject { |c| c.name == "system.indexes" }.each(&:drop)
  end
end
