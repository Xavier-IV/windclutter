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

        puts 'Created the following files:'
        Dir["#{template}/*.yml"].each do |t|
          FileUtils.cp(t, '/tmp/windclutter')
          puts "\t#{t}"
        end

        puts "\nSetup completed!".green
      end

      def self.uninstall
        Dir['/tmp/windclutter'].each do |t|
          FileUtils.rm_rf(t)
        end

        puts 'Uninstall completed!'.green
      end

      def self.create_project(value)
        FileUtils.mkdir_p("/tmp/windclutter/projects/#{value}")
      end

      def self.list_projects
        Dir['/tmp/windclutter/projects/*'].map do |t|
          t.split('/tmp/windclutter/projects/')[1]
        end
      end

      def self.scanners(extension)
        Dir["#{File.dirname(__FILE__)}/**/*#{extension}"]
      end

      def self.overwrite(file, content)
        File.open(file, 'w') { |t| t.puts content }
      end
    end
  end
end