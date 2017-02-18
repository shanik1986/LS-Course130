def each(enum)
  current_index = 0

  while current_index < enum.size
    yield(enum[current_index])
    current_index += 1
  end
  enum
end

p each([1, 2, 3, 4]) { |item| puts "The current item is #{item}" }
