# frozen_string_literal: true

require 'windclutter/processor'

class WindClutterProcessorTest < Minitest::Test
  include WindClutter::Util
  include WindClutter

  def test_able_to_generate_block
    result = Processor.build_single('class', %w[container mx-auto])

    assert_equal ".class {\n  @apply container mx-auto;\n}\n",
                 result
  end

  def test_able_to_auto_process
    Generator.stubs(:random_class).returns('windclutter:mocked_value')
    collections = []
    result = Processor.auto_process(dummy_content, collections)

    assert_equal result, expected_output
    assert_equal collections[0][:generated_name], 'windclutter:mocked_value'
    assert_equal collections[0][:class], 'flex flex-col items-center gap-6 px-10 py-40 overflow-y-scroll'
    assert_nil collections[0][:provided_name]
    assert_equal collections[0][:named], false
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
      <div class=\"windclutter:mocked_value\">
      </div>
    CONTENT
  end

  def expected_collections
    { generated_name: 'windclutter:mocked_value',
      class: 'flex flex-col items-center gap-6 px-10 py-40 overflow-y-scroll' }
  end
end
