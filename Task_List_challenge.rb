require 'date'

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
end

class DueDateTask < Task
    def initialize(date=Date.today.strftime("%Y-%m-%d"), title="title")
        @duedate = Date.parse(date).strftime("%Y-%m-%d") #this is the part that doesn't work
        super(title)
    end

    def due_date
        @duedate
    end
end
