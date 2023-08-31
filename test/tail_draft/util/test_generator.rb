# frozen_string_literal: true

require 'minitest/autorun'
require 'tail_draft/util/generator'

class TailDraftUtilGeneratorTest < Minitest::Test
  def test_able_to_randomize_class_name
    assert_match(/.[a-z]+/,
                 TailDraft::Util::Generator.random_class)
  end
end
