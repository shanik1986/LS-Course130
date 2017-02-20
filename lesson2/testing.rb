require 'minitest/autorun'

class EqualityTest < Minitest::Test
  def test_value_equality
    str1 = 'Hi there'
    str2 = 'Hi there'

    assert_equal(str1, str2)
    assert_same(str1, str2)
  end
end
