# frozen_string_literal: true

require 'minitest/autorun'
require 'tail_draft/processor'

class TailDraftProcessorTest < Minitest::Test
  def test_able_to_generate_block
    result = TailDraft::Processor.build_single('.class', %w[container mx-auto])

    assert_equal ".class {\n  @apply container mx-auto;\n}\n",
                 result
  end

  def test_able_to_auto_process
    TailDraft::Util::Generator.stub(:random_class, 'tail_draft:mocked_value') do
      collections = []
      result = TailDraft::Processor.auto_process(dummy_content, collections)

      assert_equal result, expected_output
      assert_equal collections[0][:generated_name], 'tail_draft:mocked_value'
      assert_equal collections[0][:class], 'flex flex-col items-center gap-6 px-10 py-40 overflow-y-scroll'
      assert_nil collections[0][:provided_name]
      assert_equal collections[0][:named], false
    end
  end

  private

  def dummy_content
    <<~CONTENT
      <div class="flex flex-col items-center gap-6 px-10 py-40 overflow-y-scroll">
      </div>
    CONTENT
  end

  def expected_output
    <<~CONTENT
      <div class=\"tail_draft:mocked_value\">
      </div>
    CONTENT
  end

  def expected_collections
    { generated_name: 'tail_draft:mocked_value',
      class: 'flex flex-col items-center gap-6 px-10 py-40 overflow-y-scroll' }
  end
end
