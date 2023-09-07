# frozen_string_literal: true

require 'dry/cli'
require 'windclutter/util/file_handler'
require 'windclutter/util/config'
require 'windclutter/util/generator'
require 'windclutter/processor'

module WindClutter
  module CLI
    module Commands
      module DeClutter
        # Initiate setup for specified project
        class FilePath < Dry::CLI::Command
          include WindClutter::Util

          desc 'Perform decluttering on the specified path'

          def call(**opt)
            puts
            name = Generator.random_class

            classes = WindClutter::Processor.sort(opt[:args])
            puts WindClutter::Processor.build_single(name, classes)
          end
        end
      end
    end
  end
end
