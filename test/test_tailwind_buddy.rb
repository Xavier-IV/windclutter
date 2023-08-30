# frozen_string_literal: true

require 'minitest/autorun'
require 'tailwind_buddy'

class TailwindBuddyTest < Minitest::Test
  def test_english_hello
    assert_equal 'hello world',
                 TailwindBuddy.hi('english')
  end

  def test_any_hello
    assert_equal 'hello world',
                 TailwindBuddy.hi('ruby')
  end

  def test_spanish_hello
    assert_equal 'hola mundo',
                 TailwindBuddy.hi('spanish')
  end
end
