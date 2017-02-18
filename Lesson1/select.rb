def select(enum)
  index = 0
  result = []

  while index < enum.size
    result << enum[index] if yield(enum[index])
    index += 1
  end

  result
end

p select([2, 5, 6, 7, 9, 12]) { |item| item % 2 == 0 }
