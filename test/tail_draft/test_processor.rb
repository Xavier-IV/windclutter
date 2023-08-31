# frozen_string_literal: true

require 'minitest/autorun'
require 'tail_draft/processor'

class TailDraftProcessorTest < Minitest::Test
  def test_able_to_generate_block
    result = TailDraft::Processor.build_single('.class', %w[container mx-auto])

    assert_equal ".class {\n  @apply container mx-auto;\n}\n",
                 result
  end
end
