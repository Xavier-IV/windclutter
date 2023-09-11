# frozen_string_literal: true

require 'fileutils'
require 'colorize'
require 'yaml'

module WindClutter
  module Util
    # Generator helper
    class FileHandler
      def self.init_config
        FileUtils.mkdir_p('/tmp/windclutter')

        return puts 'Setup already performed!'.yellow if File.file?('/tmp/windclutter/config.yml')

        template = File.expand_path('../../template', File.dirname(__FILE__))

        puts 'First setup of windclutter...'.green
        puts 'Created the following files:'
        Dir["#{template}/*.yml"].each do |file|
          FileUtils.cp(file, '/tmp/windclutter')
        end

        Dir['/tmp/windclutter/*'].each do |file|
          puts "\t#{file}"
        end

        puts "\nSetup completed!".green
      end

      def self.uninstall
        Dir['/tmp/windclutter'].each do |t|
          FileUtils.rm_rf(t)
        end
      end

      def self.create_project(value)
        FileUtils.mkdir_p("/tmp/windclutter/projects/#{value}")
      end

      def self.list_projects
        Dir['/tmp/windclutter/projects/*'].map do |t|
          t.split('/tmp/windclutter/projects/')[1]
        end
      end

      def self.scanners(suffixes)
        Dir[*suffixes.map { |s| "#{Dir.pwd}/**/*#{s}" }]
      end

      def self.scan_one(path)
        File.expand_path(path, Dir.pwd)
      end

      def self.overwrite(file, content)
        File.open(file, 'w') { |t| t.puts content }
      end

      def self.read(file)
        File.open(file).read
      end
    end
  end
end
