def reduce(arr, sum = 0)
  counter = 0

  while counter < arr.size
    sum = yield(sum, arr[counter])
    counter += 1
  end

  sum
end

array = [1, 2, 3, 4, 5]

# reduce(array) { |acc, num| acc + num }                    # => 15
# reduce(array, 10) { |acc, num| acc + num }                # => 25
# reduce(array) { |acc, num| acc + num if num.odd? }
