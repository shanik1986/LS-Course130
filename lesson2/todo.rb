class Todo
  attr_accessor :done
  attr_reader :title, :description

  DONE_MARKER = 'X'.freeze
  UNDONE_MARKER = ' '.freeze

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
