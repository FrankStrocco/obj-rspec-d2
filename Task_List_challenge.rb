require 'date'
require 'time'

class Task

    def initialize(title="title")
        @title = title
        @is_done = false
    end

    def title
        @title
    end

    def make_description(description="")
        @description = description
    end

    def description
        @description
    end

    def is_done
        @is_done
    end

    def switch_done
        @is_done = !@is_done
    end

    def add_label(label="")
        @label = label
    end

    def label
        @label
    end
    def print_task
        if is_done == true
            @title + " is done."
        else
            @title
        end
    end

end

class TaskList

    def initialize
        @task_array = []
        @result_array = []
        @todays_date_array = []
    end

    def add_task(my_task)
        @task_array << my_task
    end

    def task_array
        @task_array
    end


    def task_retrieve(truth)
        @result_array = []
        if truth == true
            @task_array.each do |el|
                if el.is_done == true
                    @result_array << el
                end
            end
        elsif truth == false
            @task_array.each do |x|
                if x.is_done == false
                    @result_array << x
                end
            end
        end
        @result_array
    end

    def result_array
        @result_array
    end

    def has_todays_date
        @todays_date_array = []
        todays_date = Date.today.strftime("%m-%d-%Y")
        @result_array.each do |arr|
            if arr.class == DueDateTask && todays_date == arr.show_duedate
                @todays_date_array << arr
            end
        end
        p "test"
        @todays_date_array

    end

    def sortdd
        @sortdd_arr = []
        @result_array.each do |arr|
            if arr.class == DueDateTask
                @sortdd_arr << arr
            end
        end
        @sortdd_arr.sort_by! do |obj|
            obj.due_date
        end
        @sortdd_arr
    end

    def sort_both

        @sort_both_arr = []
        @sort_task_arr = []
        puts ("@result_array: #{@result_array}")
        @result_array.each do |arr|
            if arr.class == DueDateTask
                @sort_both_arr << arr
            end
        end

        @sort_both_arr.sort_by! do |obj|
            obj.due_date
        end

        @result_array.each do |arr|
            if arr.class == Task
                @sort_task_arr << arr
            end
        end
        puts "@sorttask arr: #{@sort_task_arr}"
        @sort_task_arr.sort_by! do |obj|
            obj.title
        end

        puts "@sort_tasks_arr: #{@sort_tasks_arr}"
        @sort_task_arr.each do |arr|
            @sort_both_arr << arr
        end

        @sort_both_arr
    end
end

class DueDateTask < Task
    def initialize(date=Date.today+7, title="title")
        @duedate = date
        super(title)
    end

    def show_duedate
        if @duedate.class == Date
            @duedate = @duedate.strftime("%m-%d-%Y")
        elsif @duedate.class == String
            @duedate
        else
            raise_error.new("Date must be a string or date type")
        end
    end

    def due_date
        @duedate
    end
end

# @duedate = @duedate.strftime("%m %d %Y")

# task = DueDateTask.new
#
# task.show_duedate
# task1 = DueDateTask.new("2017-4-14")
# p task1
# task1.show_duedate
