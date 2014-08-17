require 'active_record'
require './lib/task'
require './lib/list'
require 'pry'


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
    puts "Press 'l' to view all lists or add a task to a list"
    puts "Press 't' to view all tasks for a list"
    puts "Press 'al' to add a list"
    choice = gets.chomp
    case choice
    when 'l'
      view_lists
    when 't'
      view_tasks
    when 'al'
      add_list
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
  puts "Press 'a' to add a task to a list"
  user_choice = gets.chomp
  if user_choice == 'a'
    puts "Enter the name of the list you would like to add a task to"
    user_list_name = gets.chomp
    list_for_task = List.where(name: user_list_name)
    binding.pry
    puts "Enter task name"
    user_task = gets.chomp
    inputed_task = Task.new({:name => user_task, :list_id => list_for_task.first.id, :done => false})
    inputed_task.save
    puts "#{inputed_task.name} has been added to #{list_for_task.first.name}"
  end
end

def view_lists_only
  puts "^^^^^^^LISTS^^^^^^^^"
  lists = List.all
  lists.each {|list| puts list.name}
  puts "_____________________"
end

def view_tasks
  view_lists_only
  puts "**ENTER THE NAME OF THE LIST YOU WOULD LIKE TO VIEW**"
  user_list = gets.chomp
  list = List.where(name: user_list)
  tasks_for_list = Task.where(list_id: list.first.id)
  puts "--------TASKS---------"
  tasks_for_list.each do |task|
    if task.done == false
      status = "not done"
    else
      status = "done"
    end
    puts "#{task.name} - #{status}"
  end
  puts "<<<<<<<<>>>>>>>>>"
  puts "press 'y' if you would like to see only the tasks you still have to do"
  user_choice = gets.chomp

  if user_choice == 'y'
    Task.not_done.where(list_id: list.first.id).each do |task|
      puts "#{task.name}"
    end
    puts "<<<<<<<>>>>>>>"
  else
    puts "<<<<<<<>>>>>>>"
  end
end

def add_list
  puts "**ENTER LIST NAME**"
  user_list = gets.chomp
  list = List.new({:name => user_list})
    if list.save
      puts "#{list.name} has been added"
    else
      puts "That wasn't a valid list"
      list.errors.full_messages.each { |message| puts message }
    end
  puts "\n"
  puts "\n"
end




welcome
