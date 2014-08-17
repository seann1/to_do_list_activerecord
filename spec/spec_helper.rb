require 'active_record'
require 'rspec'
require 'shoulda-matchers'

require './lib/task.rb'
require './lib/list.rb'

ActiveRecord::Base.establish_connection(YAML::load(File.open('./db/config.yml'))["test"])

RSpec.configure do |config|
  config.after(:each) do
    Task.all.each { |task| task.destroy}
    List.all.each { |list| list.destroy}
  end
end
