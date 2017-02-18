
def times(iterations)
  counter = 0

  while counter < 5
    yield(counter)
    counter += 1
  end

  counter
end

times(5) do |i|
  puts i
end
