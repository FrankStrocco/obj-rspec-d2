require 'rspec'
require_relative 'Task_List_challenge'
require 'date'
require 'time'


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
        due_date_task_one = DueDateTask.new("4-15-2018", "Task 3")
        our_task_list.add_task(due_date_task_one)
        expect(our_task_list.task_array[2].title).to eq("Task 3")
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

    it "can show non-completed tasks that are due today" do
        t_list1 = TaskList.new
        task_one = Task.new("Task one")
        task_two = Task.new("Task two")
        t_list1.add_task(task_one)
        t_list1.add_task(task_two)
        task_one.switch_done
        ddtask_one = DueDateTask.new("10-20-2019", "2019 Task")
        t_list1.add_task(ddtask_one)
        ddtask_two = DueDateTask.new("10-20-2017", "Done already")
        ddtask_two.switch_done
        ddtask_three = DueDateTask.new("10-27-2017", "Due today not done")
        ddtask_four = DueDateTask.new("10-27-2017", "Due today done")
        ddtask_four.switch_done
        t_list1.add_task(ddtask_three)
        t_list1.add_task(ddtask_four)
        # expect(t_list1.task_retrieve(false).has_todays_date).to eq([ddtask_three])
        t_list1.task_retrieve(false)
        p t_list1.result_array
        expect(t_list1.has_todays_date).to match_array([ddtask_three])
    end

    it "can list all the not completed items in order of due date." do
        t_list1 = TaskList.new
        task_one = Task.new("Task one")
        task_two = Task.new("Task two")
        t_list1.add_task(task_one)
        t_list1.add_task(task_two)
        task_one.switch_done
        ddtask_one = DueDateTask.new("10-20-2019", "2019 Task")
        t_list1.add_task(ddtask_one)
        ddtask_two = DueDateTask.new("10-20-2017", "Done already")
        ddtask_two.switch_done
        ddtask_three = DueDateTask.new("10-27-2017", "Due today not done")
        ddtask_four = DueDateTask.new("10-27-2017", "Due today done")
        ddtask_four.switch_done
        ddtask_five = DueDateTask.new("12-20-2017", "Due in December")
        t_list1.add_task(ddtask_five)
        ddtask_six = DueDateTask.new("10-15-2017", "Due last week, not done")
        t_list1.add_task(ddtask_three)
        t_list1.add_task(ddtask_four)
        t_list1.add_task(ddtask_six)
        t_list1.task_retrieve(false)
        expect(t_list1.sortdd).to match_array([ddtask_six, ddtask_three, ddtask_five, ddtask_one])
    end
    it "can list all the not completed items in order of due date, and then the items without due dates" do
        t_list1 = TaskList.new
        task_one = Task.new("Task one")
        task_two = Task.new("Task two")
        task_banana = Task.new("Task banana")
        t_list1.add_task(task_one)
        task_one.switch_done
        ddtask_one = DueDateTask.new("10-20-2019", "2019 Task")
        t_list1.add_task(ddtask_one)
        t_list1.add_task(task_banana)
        ddtask_two = DueDateTask.new("10-20-2017", "Done already")
        ddtask_two.switch_done
        ddtask_three = DueDateTask.new("10-27-2017", "Due today not done")
        ddtask_four = DueDateTask.new("10-27-2017", "Due today done")
        ddtask_four.switch_done
        ddtask_five = DueDateTask.new("12-20-2017", "Due in December")
        t_list1.add_task(ddtask_five)
        ddtask_six = DueDateTask.new("10-15-2017", "Due last week, not done")
        t_list1.add_task(ddtask_three)
        t_list1.add_task(ddtask_four)
        t_list1.add_task(ddtask_six)
        t_list1.task_retrieve(false)
        expect(t_list1.sort_both).to match_array([ddtask_six, ddtask_three, ddtask_five, ddtask_one, task_banana])
    end
end
describe "Due date task" do
    it "is a Task with a due date" do
        expect{DueDateTask.new}.to_not raise_error
        due_date_task_one = DueDateTask.new
        expect(due_date_task_one.due_date).to eq((Date.today+7))
        due_date_task_two = DueDateTask.new('1-20-2018')
        expect((due_date_task_two).class.superclass).to eq(Task)
        expect(due_date_task_two.due_date).to eq("1-20-2018")
        due_date_task_one.add_label("This is a label.")
        expect(due_date_task_one.label).to eq("This is a label.")
    end
end
