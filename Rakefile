# frozen_string_literal: true

require 'rake/testtask'
require 'bump/tasks'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc 'Run tests'
task default: :test

desc 'Run the Windclutter executable'
task :windclutter, [:args] do
  args = ARGV[1..]  # Capture all arguments after the task name
  begin
    cmd = "ruby -Ilib ./bin/windclutter #{args.join(' ')}"
    sh cmd
  ensure
    exit 0
  end
end

namespace :gem do
  desc 'Build the gem'
  task :build do
    sh 'gem build windclutter.gemspec'
  end

  desc 'Push the latest gem that was built.'
  task :push do
    gem_file = Dir.glob('*.gem').max_by { |f| File.mtime(f) }

    if gem_file.nil?
      puts 'No gem file found in the current directory.'
    else
      puts "Pushing gem: #{gem_file}"
      sh "gem push #{gem_file}"
    end
  end

  desc 'Clean all built gem.'
  task :clean do
    gem_files = Dir.glob('*.gem')
    Dir.glob('*.gem').each do |gem_file|
      File.delete(gem_file) if File.exist?(gem_file)
    end
    puts "#{gem_files.count} gems cleaned!"
  end
end
