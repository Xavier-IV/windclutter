# frozen_string_literal: true

require 'awesome_print'
require 'dry/cli'
require 'windclutter/version'
require 'windclutter/util/file_handler'
require 'windclutter/cli/commands/project'
require 'windclutter/cli/commands/generate'
require 'windclutter/cli/commands/analysis'

module WindClutter
  module CLI
    # Command module to be use by CLI
    module Commands
      extend Dry::CLI::Registry

      # Print out the version of windclutter
      class ShowVersion < Dry::CLI::Command
        desc 'Print version'

        def call(*)
          puts WindClutter::VERSION
        end
      end

      # Uninstallation handler
      class Uninstall < Dry::CLI::Command
        include WindClutter::Util

        desc 'Remove all windclutter setup and configurations'

        def call(*)
          FileHandler.uninstall
        end
      end

      # A helper for you to dissect the configuration quickly
      class Debug < Dry::CLI::Command
        include WindClutter::Util

        desc 'Debug the configuration of windclutter'

        def call(*)
          ap Config.wtf?
        end
      end

      register 'version', ShowVersion, aliases: %w[v -v --version]
      register 'use', Commands::Project::Use, aliases: %w[u -u --use]
      register 'uninstall', Uninstall, aliases: %w[u -u --uninstall]
      register 'debug', Debug, aliases: %w[d -d --debug]

      register 'project', aliases: ['p'] do |prefix|
        prefix.register 'list', Commands::Project::List
        prefix.register 'current', Commands::Project::Current
        prefix.register 'dump-path', Commands::Project::DumpPath, aliases: ['-d']
        prefix.register 'config', Commands::Project::ConfigUpdate, aliases: ['-c']
      end

      register 'analysis', aliases: %w[a -a] do |prefix|
        prefix.register 'file', Commands::Analysis::FilePath, aliases: ['-p']
        prefix.register 'traverse', Commands::Analysis::Traverse, aliases: ['-t']
      end

      register 'generate', aliases: ['g'] do |prefix|
        prefix.register 'on-fly', Commands::Generate::OnFly
      end
    end
  end
end
