require 'spec_helper'

describe Task do
  it 'can return the not done tasks' do
    not_done_tasks = (1..5).to_a.map { |number| Task.create(:name => "task #{number}", :done => false) }
    done_task = Task.create({:name => "done task", :done => true})
    Task.not_done.should eq not_done_tasks
  end

  it 'belongs to a list' do
    list = List.create({:name => "homework"})
    task1 = Task.create({:name => "sit down", :list_id => list.id})
    task1.list.should eq list
  end

  it 'validates presence of a name' do
    task = Task.new({:name => ''})
    task.save.should eq false
  end

  it 'ensures that a task name is less than 50 characters long' do
    task = Task.new({:name => 'a' * 51})
    task.save.should eq false
  end
end
