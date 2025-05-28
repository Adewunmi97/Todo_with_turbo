# spec/models/todo_spec.rb
require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'is valid with a title and valid status' do
    todo = Todo.new(title: 'Test Task', status: 'incomplete')
    expect(todo).to be_valid
  end

  it 'is not valid without a title' do
    todo = Todo.new(status: 'complete')
    expect(todo).not_to be_valid
  end

  it 'is not valid with an invalid status' do
    todo = Todo.new(title: 'Test Task', status: 'pending')
    expect(todo).not_to be_valid
  end

  it 'is valid with status complete' do
    todo = Todo.new(title: 'Finished Task', status: 'complete')
    expect(todo).to be_valid
  end
end
