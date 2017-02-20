require 'minitest/autorun'

require_relative 'car'

class CarTest < MiniTest::Test
  def setup
    @car = Car.new
  end

  def test_wheels
    assert_equal(4, @car.wheels)
  end

  def test_car_exists
    assert(@car)
  end

  def test_name_is_nil
    assert_nil(@car.name)
  end

  def test_raises_initialize_with_arg
    assert_raises(ArgumentError) do
      car = Car.new(name: 'Joey')
    end
  end

  def test_car_instance
    assert_instance_of(Car, @car)
  end

  def test_includes_car
    arr = [1, 2, 3]
    arr << @car

    assert_includes(arr, @car)
  end
end
