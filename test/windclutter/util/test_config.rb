# frozen_string_literal: true

require 'windclutter/analyser'
require 'windclutter/util/config'

class WindClutterUtilConfigTest < Minitest::Test
  include WindClutter::Util

  def test_it_can_update
    config = {}
    Config.expects(:exists?).returns(true)
    YAML.stubs(:load_file).with('/tmp/windclutter/config.yml').returns(config)
    File.expects(:open).with('/tmp/windclutter/config.yml', 'w').once

    Config.update('key', 'value')
    assert_equal config['key'], 'value'
  end

  def test_it_can_setup_project
    config = { 'projects' => {} }
    Config.expects(:exists?).returns(true)
    YAML.stubs(:load_file).with('/tmp/windclutter/config.yml').returns(config)
    File.expects(:open).with('/tmp/windclutter/config.yml', 'w').once

    Config.setup_project('project_name')
    assert_equal config['projects']['project_name'],
                 { 'project_path' => nil, 'dump_path' => nil, 'class_key' => 'class', 'class_start' => '"',
                   'class_end' => '"' }
  end

  def test_it_can_update_project
    config = { 'projects' => {} }
    Config.expects(:exists?).returns(true)
    YAML.stubs(:load_file).with('/tmp/windclutter/config.yml').returns(config)
    File.expects(:open).with('/tmp/windclutter/config.yml', 'w').once

    Config.update_project('project_name', 'key', 'value')
    assert_equal config['projects']['project_name']['key'],
                 'value'
  end

  def test_it_can_read_project
    config = { 'projects' => { 'project_name' => { 'key' => 'read_value' } } }
    Config.expects(:exists?).returns(true)
    YAML.stubs(:load_file).with('/tmp/windclutter/config.yml').returns(config)

    assert_equal Config.read_project('project_name', 'key'),
                 'read_value'
  end

  def test_it_can_read
    config = { 'key' => 'value' }
    Config.expects(:exists?).returns(true)
    YAML.stubs(:load_file).with('/tmp/windclutter/config.yml').returns(config)

    assert_equal Config.read('key'), 'value'
  end

  def test_it_can_wtf
    config = { 'key' => 'value' }
    Config.expects(:exists?).returns(true)
    YAML.stubs(:load_file).with('/tmp/windclutter/config.yml').returns(config)

    assert_equal Config.wtf?, config
  end

  def test_it_verifies_config_exists
    File.expects(:file?).with('/tmp/windclutter/config.yml').returns(true)

    assert_equal Config.exists?, true
  end

  def test_it_verifies_config_not_exists
    File.expects(:file?).with('/tmp/windclutter/config.yml').returns(false)

    assert_equal Config.exists?, false
  end
end
