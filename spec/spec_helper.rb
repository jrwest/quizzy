current_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(current_dir)
$LOAD_PATH.unshift(File.join(current_dir, '..'))
$LOAD_PATH.unshift(File.join(current_dir, %w[.. models]))

require 'rubygems'
require 'spec'

