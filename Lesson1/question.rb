class Todo
  attr_reader :done

  DONE_MARKER = 'X'.freeze
  UNDONE_MARKER = ''.freeze

  def initialize(title, description = '')
    @title = title
    @description = description
    @done = false
  end

  def done?
    done
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] Doind something"
  end
end

class TodoList
  attr_reader :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(item)
    raise TypeError, "Can only add Todo objects" unless item.instance_of?(Todo)
    todos << item
  end

  def to_s
    "#{todos}"
  end
end

list = TodoList.new("Today's Todos")

list.add(Todo.new("Buy milk"))
list.add(Todo.new("Clean room"))
list.add(Todo.new("Go to gym"))

puts list
