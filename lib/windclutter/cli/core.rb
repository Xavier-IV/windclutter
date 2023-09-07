# frozen_string_literal: true

require 'dry/cli'
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
      class Version < Dry::CLI::Command
        desc 'Print version'

        def call(*)
          puts '0.0.1'
        end
      end

      # Perform initial setup for windclutter
      class Install < Dry::CLI::Command
        include WindClutter::Util

        desc 'Initiate first setup for windclutter'

        def call(*)
          FileHandler.init_config
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
          puts Config.wtf?
        end
      end

      register 'version', Version, aliases: %w[v -v --version]
      register 'install', Install, aliases: %w[i -i --install]
      register 'uninstall', Uninstall, aliases: %w[u -u --uninstall]
      register 'debug', Debug, aliases: %w[d -d --debug]

      register 'project', aliases: ['p'] do |prefix|
        prefix.register 'init', Commands::Project::Init
        prefix.register 'list', Commands::Project::List
        prefix.register 'use', Commands::Project::Use
        prefix.register 'current', Commands::Project::Current
        prefix.register 'dump-path', Commands::Project::DumpPath, aliases: ['-d']
        prefix.register 'config', Commands::Project::ConfigUpdate, aliases: ['-c']
      end

      register 'analysis', aliases: %w[a -a] do |prefix|
        prefix.register 'file', Commands::Analysis::FilePath, aliases: ['-p']
      end

      register 'generate', aliases: ['g'] do |prefix|
        prefix.register 'on-fly', Commands::Generate::OnFly
      end
    end
  end
end
