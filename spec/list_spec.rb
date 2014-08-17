require 'spec_helper'

describe List do
  it "has many tasks" do
    list = List.create({:name => "list"})
    task1 = Task.create({:name => "task1", :list_id => list.id})
    task2 = Task.create({:name => "task2", :list_id => list.id})
    list.tasks.should eq [task1, task2]
  end

  it 'validates presence of a name' do
    list = List.new({:name => ''})
    list.save.should eq false
  end

  it 'ensures that a list name is less than 50 characters long' do
    list = List.new({:name => 'a' * 51})
    list.save.should eq false
  end
end
