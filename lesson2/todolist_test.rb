require 'minitest/autorun'
require 'simplecov'
SimpleCov.start
# require "minitest/reporters"
# Minitest::Reporters.use!

require_relative 'todolist'

class TodoListTest < MiniTest::Test
  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@list.size, 3)
  end

  def test_first
    assert_equal(@list.first, @todo1)
  end

  def test_last
    assert_equal(@list.last, @todo3)
  end

  def test_shift
    assert_equal(@list.shift, @todo1)
    assert_equal(@list.to_a, [@todo2, @todo3])
  end

  def test_pop
    todo = @list.pop
    assert_equal(todo, @todo3)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(@list.done?, false)
  end

  def test_raises_type_error
    assert_raises(TypeError) { @list << 3 }
    assert_raises(TypeError) { @list << 'Hi' }
  end

  def test_shovel_add
    new_todo = Todo.new("Test Program")
    @list << new_todo
    assert_equal(@list.to_a, @todos + [new_todo])
  end

  def test_add
    new_todo = Todo.new("Test Program")
    @list << new_todo
    assert_equal(@list.to_a, @todos + [new_todo])
  end

  def test_item_at
    assert_equal(@list.item_at(0), @todo1)
    assert_equal(@list.item_at(2), @todo3)
    assert_raises(IndexError) { @list.item_at(5) }
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    @list.mark_done_at(1)
    assert_equal(@todo1.done?, true)
    assert_equal(@todo2.done?, true)
    assert_equal(@todo3.done?, false)
    assert_raises(IndexError) { @list.mark_done_at(100) }
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_done_at(100) }

    @todo1.done!
    @todo2.done!
    @todo3.done!

    @list.mark_undone_at(0)

    assert_equal(@todo1.done?, false)
    assert_equal(@todo2.done?, true)
    assert_equal(@todo3.done?, true)
  end

  def test_mark_all_done!
    @list.mark_all_done!

    assert_equal(@todo1.done?, true)
    assert_equal(@todo2.done?, true)
    assert_equal(@todo3.done?, true)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }

    @list.remove_at(1)
    assert_equal(@list.to_a, [@todo1, @todo3])
  end

  def test_to_s
    output = <<~OUTPUT.chomp
    ----Today's Todos----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    done_output = <<~OUTPUT.chomp
    ----Today's Todos----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT

    @todo2.done!
    assert_equal(@list.to_s, done_output)
  end

  def test_each
    copied_todo = []
    each_result = @list.each { |item| copied_todo << item }

    assert_equal(@list, each_result)
    assert_equal(@todos, copied_todo)
  end

  def test_select
    assert_equal([], @list.select(&:done?).to_a)

    @todo1.done!
    assert_equal(@list.select(&:done?).to_a, [@todo1])

    assert_equal(@list.select { |item| !item.done? }.to_a, [@todo2, @todo3])
  end
end
