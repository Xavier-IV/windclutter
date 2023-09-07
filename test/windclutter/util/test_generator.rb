# frozen_string_literal: true

require 'windclutter/util/generator'

class WindClutterUtilGeneratorTest < Minitest::Test
  def test_able_to_randomize_class_name
    assert_match(/.[a-z]+/,
                 WindClutter::Util::Generator.random_class)
  end
end
