# frozen_string_literal: true

require 'dry/cli'
require 'windclutter/util/file_handler'
require 'windclutter/util/config'

module WindClutter
  module CLI
    module Commands
      module Project
        # Initiate setup for specified project
        class Init < Dry::CLI::Command
          include WindClutter::Util

          desc 'Setup windclutter for your project'

          argument :name, required: true, desc: 'Name of your project.'

          def call(name:, **)
            FileHandler.create_project(name)
            puts 'Successfully created!'.green
          end
        end

        # List all of created project for windclutter
        class List < Dry::CLI::Command
          include WindClutter::Util

          desc 'List all of created windclutter project.'

          def call(**)
            puts FileHandler.list_projects
          end
        end

        # Use specified project
        class Use < Dry::CLI::Command
          include WindClutter::Util

          desc 'Use the project, automatically create one if not exists yet.'

          argument :name, required: true, desc: 'Name of your project.'

          def call(name:, **)
            return Config.read('active_project') if name.nil?

            unless FileHandler.list_projects.include? name
              FileHandler.create_project(name)
              puts 'No project, we created one instead'.green
            end

            Config.update('active_project', name)
            puts "Using project \"#{name}\"".green
          end
        end
      end
    end
  end
end
