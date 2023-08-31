# frozen_string_literal: true

require 'fileutils'
require 'colorize'
require 'yaml'

module TailDraft
  module Util
    # Generator helper
    class FileHandler
      def self.init_config
        FileUtils.mkdir_p('/tmp/tail_draft')

        return puts 'Setup already performed!'.yellow if File.file?('/tmp/tail_draft/config.yml')

        template = File.expand_path('../../template', File.dirname(__FILE__))

        puts 'Created the following files:'
        Dir["#{template}/*.yml"].each do |t|
          FileUtils.cp(t, '/tmp/tail_draft')
          puts "\t#{t}"
        end

        puts "\nSetup completed!".green
      end

      def self.uninstall
        Dir['/tmp/tail_draft'].each do |t|
          FileUtils.rm_rf(t)
        end

        puts 'Uninstall completed!'.green
      end

      def self.create_project(value)
        FileUtils.mkdir_p("/tmp/tail_draft/projects/#{value}")
      end

      def self.list_projects
        Dir['/tmp/tail_draft/projects/*'].map do |t|
          t.split('/tmp/tail_draft/projects/')[1]
        end
      end
    end
  end
end
