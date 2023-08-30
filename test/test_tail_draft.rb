# frozen_string_literal: true

require 'minitest/autorun'
require 'tail_draft'

class TailwindBuddyTest < Minitest::Test
  def test_english_hello
    assert_equal 'hello world',
                 TailDraft::CLI.hello('english')
  end

  def test_any_hello
    assert_equal 'hello world',
                 TailDraft::CLI.hello('ruby')
  end

  def test_spanish_hello
    assert_equal 'hola mundo',
                 TailDraft::CLI.hello('spanish')
  end
end
