# frozen_string_literal: true

require 'dry/cli'
require 'windclutter/analyser'
require 'windclutter/util/file_handler'
require 'windclutter/cli/commands/project'
require 'windclutter/cli/commands/generate'

module WindClutter
  module CLI
    module Commands
      module Analysis
        # Initiate setup for specified project
        class FilePath < Dry::CLI::Command
          include WindClutter::Util

          desc 'Perform CSS analysis of the path'
          argument :path, aliases: ['-p'], required: true, desc: 'Path of your CSS file to be dump.'

          def call(path:, **)
            puts "Analysing #{path}...".green

            file = File.open(FileHandler.scan_one(path))
            puts 'Done!'.green
            puts WindClutter::Analyser.init(file.read)
          end
        end
      end
    end
  end
end
