# frozen_string_literal: true

require 'thor'
require 'fileutils'
require 'windclutter/processor'
require 'windclutter/util/generator'
require 'windclutter/util/file_handler'
require 'windclutter/util/config'

module WindClutter
  # CLI implementation for windclutter
  class CLI < Thor
    include WindClutter::Util
    attr_reader :config_folder

    option :name
    option :overwrite

    def initialize(args = nil, options = nil, config = nil)
      @config_folder = '/tmp/windclutter'
      super
    end

    # Install the proper configuration
    desc 'install', 'Perform initial setup for windclutter'.green

    def install
      FileHandler.init_config
    end

    # Init your project with windclutter
    #
    #    WindClutter::CLI.init(<project_name>)
    desc 'init PROJECT_NAME', 'The name of your project'.green

    def init(name)
      FileHandler.create_project(name)
      puts 'Successfully created!'.green
    end

    desc 'list-projects', 'List of projects'.green

    def list_projects
      FileHandler.list_projects
    end

    desc 'scan', 'Scan directory for classes, default targeting .html'
    def scan(target = '.html')
      puts 'Overwriting in progress...'.red unless options[:overwrite].nil?
      collections = []
      FileHandler.scanners(target).map do |file|
        file_stream = WindClutter::Processor.auto_process(File.read(file), collections)

        unless options[:overwrite].nil?
          FileHandler.overwrite(file, file_stream)
          puts 'Overwrite completed'.green
        end
      end
    end

    # Draft the list of classes
    #
    #    WindClutter::CLI.draft(<tailwind class_names>)
    desc 'draft CLASS_NAMES', 'Provide a list of class'

    def draft(*class_names)
      name = options[:name]
      name = Generator.random_class if name.to_s.empty?

      classes = WindClutter::Processor.sort(class_names)
      WindClutter::Processor.build_single(name, classes)
    end

    desc 'use PROJECT_NAME', 'Use the project, automatically create one if not exists yet.'

    def use(project_name = nil)
      return Config.read('active_project') if project_name.nil?

      unless FileHandler.list_projects.include? project_name
        FileHandler.create_project(project_name)
        puts 'No project, we created one instead'.green
      end

      Config.update('active_project', project_name)
      puts "Using project \"#{project_name}\"".green
    end

    desc 'uninstall', 'Remove all configurations and project'.red

    def uninstall
      FileHandler.uninstall
    end
  end
end
