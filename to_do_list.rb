require 'active_record'
require './lib/task'
require './lib/list'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)


def welcome
  puts '  ~~~~~~~~~~~~~~~~~~~~~~~*~~~~~~~~~~~~~~~~~~~~
  ~~~~~*~~~~~~~~TO DO LIST~~~~~~~~~~~~~~~~~~~~
  ~~~~~~~~~~~~~~~~~~~~~*~~~~~~~~~~~~~~~@~~~~~~
  ~~~~~~~~~~~~*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "Press 'l' to view all lists"
    puts "Press 't' to view tasks for a list"
    puts "Press 'al' to add a list"
    puts "Press 'at' to add a task"
    choice = gets.chomp
    case choice
    when 'l'
      view_lists
    when 't'
      view_tasks
    when 'al'
      add_list
    when 'at'
      add_task
    when 'x'
      exit
    else
      puts 'NOT VALID'
    end
  end
end

def view_lists
  puts "^^^^^^^LISTS^^^^^^^^"
  lists = List.all
  lists.each {|list| puts list.name}
  puts "^^^^^^^^^^^^^^^^^^^^"
end

def view_tasks
  view_lists
  puts "**ENTER THE NAME OF THE LIST YOU WOULD LIKE TO VIEW**"
  user_list = gets.chomp
  list = List.where(name: user_list)
  tasks_for_list = Task.where(list_id: list.id)
  puts "********TASKS*********"
  tasks_for_list.each do |task|
    puts task.name
  end
end

def add_list
  puts "**ENTER LIST NAME"
  user_list = gets.chomp
  list = List.create({:name => user_list})
  puts "\n"
  puts "<<<<#{list.name} was created>>>>"
  puts "\n"
end





welcome
