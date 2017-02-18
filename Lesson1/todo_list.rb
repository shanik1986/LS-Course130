class Todo
  attr_accessor :done
  attr_reader :title, :description

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

  def done!
    self.done = true
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_reader :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def <<(item)
    raise TypeError, "Can only add Todo objects" unless item.instance_of?(Todo)
    todos << item
  end

  alias_method :add, :<<

  def size
    todos.size
  end

  def to_s
    text = "----#{title}----\n"
    text << todos.map(&:to_s).join("\n")
    text
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def item_at(index)
    todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    todos.delete(item_at(index))
  end

  def each
    todos.each { |item| yield(item) }
    self
  end

  def select
    result = TodoList.new(title)
    each { |item| result << item if yield(item) }
    result
  end

  def find_by_title(title_query)
    each { |item| return item if item.title == title_query }
    nil
  end

  def all_done
    select(&:done?)
  end

  def all_not_done
    select { |item| !item.done? }
  end

  def mark_done(todo_title)
    result = find_by_title(todo_title)
    result && result.done!
  end

  def mark_all_done
    each(&:done!)
  end

  def mark_all_undone
    each(&:undone!)
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
todo4 = Todo.new("Buy milk2")
list = TodoList.new("Today's Todos")

list << todo1
list.add(todo2)
list.add(todo3)
list << todo4

todo4.done!
list.mark_done_at(1)

# list.mark_done("Go to gym")
# list.mark_all_undone

puts list
