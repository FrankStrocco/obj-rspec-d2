require 'rspec'
require_relative 'Task_List_challenge'


describe "Task" do

    it "can create a task" do
        expect{Task.new}.to_not raise_error
    end
    it "give a task a title and retrieve it" do
        new_task = Task.new("This is a title")
        expect(new_task.title).to be_a(String)
        expect(new_task.title).to eq("This is a title")
    end
    it "will have recieve a description and it will be retrievable" do
        new_task = Task.new
        expect(new_task.make_description).to eq("")
        expect(new_task.make_description("has some stuff written in here")).to eq("has some stuff written in here")
        expect(new_task.description).to eq("has some stuff written in here")
    end
    it "will be able to be marked done" do
        new_task = Task.new
        expect(new_task.is_done).to eq(false)
        expect(new_task.switch_done).to eq(true)
        expect(new_task.is_done).to eq(true)
        expect(new_task.switch_done).to eq(false)
        expect(new_task.is_done).to eq(false)
    end
    it "will show its status when it is done" do
        new_task = Task.new
        expect(new_task.switch_done).to eq(true)
        expect(new_task.print_task).to eq(new_task.title + " is done.")
    end
    it "can add all Tasks to a TaskList" do
        expect{TaskList.new}.to_not raise_error
        task_one = Task.new("Task_one")
        our_task_list = TaskList.new
        expect(our_task_list.add_task(task_one)).to match_array([task_one])
        task_two = Task.new("Task two")
        our_task_list.add_task(task_two)
        expect(our_task_list.task_array[1].title).to eq("Task two")
    end
end
describe "Task list" do
    it "can get the completed items" do
        task_one = Task.new("Task one")
        task_two = Task.new("Task two")
        task_three = Task.new("Task three")
        task_four = Task.new("Task four")
        task_list = TaskList.new
        task_one.switch_done
        task_three.switch_done
        task_list.add_task(task_one)
        task_list.add_task(task_two)
        task_list.add_task(task_three)
        task_list.add_task(task_four)
        expect(task_list.task_retrieve(true)).to match_array([task_one, task_three])
        expect(task_list.task_retrieve(false)).to match_array([task_two, task_four])
    end
end
describe "Due date task" do
    it "is a Task with a due date" do
        expect{DueDateTask.new}.to_not raise_error
        due_date_task_one = DueDateTask.new('2017-10-27')
        expect((due_date_task_one).class.superclass).to eq(Task)
        expect(due_date_task_one.due_date).to eq("2017-10-27")
    end
end
