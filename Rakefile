#encoding: UTF-8
require 'rake/testtask'

Rake::TestTask.new do |test|
  test.pattern = 'test/**/*_test.rb'
  test.libs << 'test'
end


begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "kindable"
    gem.summary = "Manage 'kind columns' on ActiveRecord Models easily"
    gem.email = "xurde.fdez@gmail.com"
    gem.authors = ["Xurde Fernandez"]
    gem.files = Dir["{lib}/**/*", "{rails}/**/*"]
  end
  Jeweler::GemcutterTasks.new
rescue
  puts "Jeweler or dependency not available."
end