# frozen_string_literal: true

require 'dry/cli'
require 'windclutter/util/file_handler'
require 'windclutter/util/config'

module WindClutter
  module CLI
    module Commands
      module Project
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

          argument :name, desc: 'Name of your project.'

          def call(name: nil, **)
            project_name = name || File.basename(Dir.pwd)

            FileHandler.init_config unless Config.exists?
            unless FileHandler.list_projects.include? project_name
              FileHandler.create_project(project_name)
              puts 'No project, we created one instead'.yellow
            end

            Config.update('active_project', project_name)
            Config.setup_project(project_name)
            Config.update_project(project_name, 'project_path', Dir.pwd)
            puts "Using project \"#{project_name}\"".green
          end
        end

        # Show current active project
        class Current < Dry::CLI::Command
          include WindClutter::Util

          desc 'Show which current project is actively used.'

          def call(**)
            project_name = Config.read('active_project')

            print 'Currently using: '.green
            puts project_name
          end
        end

        # Dump the generated CSS to the specified file
        class DumpPath < Dry::CLI::Command
          include WindClutter::Util

          desc 'Dump path for the generated CSS'

          argument :path, required: true, desc: 'Path of your CSS file to be dump.'

          def call(path:, **)
            active_project = Config.read('active_project')
            return puts 'No project specified. Select a project with `use` command.'.yellow if active_project.nil?

            dump_path = File.expand_path(path, Dir.pwd)

            Config.update_project(active_project, 'dump_path', dump_path)
          end
        end

        # Update config
        class ConfigUpdate < Dry::CLI::Command
          include WindClutter::Util

          desc 'Update the config for your project'

          argument :key, required: true, desc: 'Key of your config.'
          argument :value, required: true, desc: 'Value of your config.'

          def call(key:, value:, **)
            active_project = Config.read('active_project')
            return puts 'No project specified. Select a project with `use` command.'.yellow if active_project.nil?

            puts "Updating #{key}:#{value}".green

            Config.update_project(active_project, key, value)
          end
        end
      end
    end
  end
end
