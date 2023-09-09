# frozen_string_literal: true

require 'windclutter/analyser'
require 'windclutter/util/config'
require 'mocha/minitest'

class WindClutterAnalyserTest < Minitest::Test
  include WindClutter
  include WindClutter::Util
  def test_able_to_analyse_content
    Config.expects(:read).returns('test_project')
    File.stubs(:file?).with('/tmp/windclutter/config.yml').returns(true)
    Config.any_instance.stubs(:exists?).returns(true)
    YAML.stubs(:load_file).with('/tmp/windclutter/config.yml').returns(config_fixture)

    assert_equal Analyser.init(dummy_content), expected_output
  end

  def test_able_to_traverse
    FileHandler.stubs(:scanners).with('.html').returns(['src/index.html'])
    FileHandler.stubs(:read).returns(dummy_content)
    Analyser.stubs(:init).returns(expected_output)

    assert_equal Analyser.traverse('.html', 10),
                 [7, expected_output, 1]
  end

  private

  def dummy_content
    <<~CONTENT
      <div class="flex flex-col items-center gap-6 px-10 py-40 overflow-y-scroll">
      </div>
    CONTENT
  end

  def expected_output
    { 'flex' => 1, 'flex-col' => 1, 'items-center' => 1, 'gap-6' => 1, 'px-10' => 1, 'py-40' => 1,
      'overflow-y-scroll' => 1 }
  end
end
