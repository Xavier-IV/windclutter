# frozen_string_literal: true

require 'windclutter/util/file_handler'

class WindClutterUtilFileHandlerTest < Minitest::Test
  include WindClutter::Util

  def test_it_can_uninstall
    Dir.stubs(:[]).returns(['/tmp/windclutter'])
    FileUtils.stubs(:rm_rf).times(1)
    FileHandler.uninstall
  end

  def test_it_can_create_project
    FileUtils.expects(:mkdir_p).with('/tmp/windclutter/projects/project_name').times(1)
    FileHandler.create_project('project_name')
  end

  def test_it_can_list_projects
    Dir.stubs(:[]).returns(['/tmp/windclutter/projects/project_name'])
    assert_equal FileHandler.list_projects, ['project_name']
  end

  def test_scanners
    folder = '/project_folder'
    Dir.stubs(:pwd).returns(folder)
    Dir.stubs(:[]).returns(["#{folder}src/project_name/file.html"])
    assert_equal FileHandler.scanners('.html'), ["#{folder}src/project_name/file.html"]
  end

  def test_scan_one
    Dir.stubs(:pwd).returns('/project_folder')
    File.expects(:expand_path).with('src/index.html', '/project_folder').returns('/project_folder/src/index.html')
    assert_equal FileHandler.scan_one('src/index.html'), '/project_folder/src/index.html'
  end

  def test_overwrite
    test_content = 'This is a test.'

    file_mock = mock
    file_mock.expects(:puts).with(test_content)

    File.expects(:open).with('file.txt', 'w').yields(file_mock)

    FileHandler.overwrite('file.txt', test_content)
  end

  def test_read
    file_content = 'This is the file content.'
    file_path = 'test_file.txt'

    File.stubs(:open).with(file_path).returns(mock(read: file_content))

    result = FileHandler.read(file_path)

    assert_equal file_content, result
  end
end
