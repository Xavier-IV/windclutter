# frozen_string_literal: true

require 'awesome_print'
require 'dry/cli'
require 'windclutter/analyser'
require 'windclutter/util/file_handler'
require 'windclutter/util/collector'
require 'windclutter/util/sorter'
require 'windclutter/cli/commands/project'
require 'windclutter/cli/commands/generate'

module WindClutter
  module CLI
    module Commands
      module Analysis
        # Initiate setup for specified project
        class FilePath < Dry::CLI::Command
          include WindClutter
          include WindClutter::Util

          desc 'Perform CSS analysis of the path'
          argument :file, aliases: ['-f'], required: true, desc: 'Path of your CSS file to be dump.'

          def call(file:, **)
            return puts "No file found #{file}".red unless File.file?(file)

            puts "Analysing #{file}...".yellow

            content = File.open(FileHandler.scan_one(file))
            puts 'Done!'.green
            ap Analyser.init(content.read)
          end
        end

        # Perform full traversal analysis
        class Traverse < Dry::CLI::Command
          include WindClutter
          include WindClutter::Util

          desc 'Perform full traversal analysis'

          argument :suffix, aliases: ['-s'], required: true, desc: 'Suffix of all files to be traversed.'

          option :full, type: :boolean, alias: '-f', default: false, desc: 'Print out whole classes.'

          option :collect, type: :integer, alias: '-c', default: 5, desc: 'Specify how many of result to collect.'

          def call(suffix:, **options)
            full = options.fetch(:full)
            collect_count = full ? 0 : options.fetch(:collect).to_i
            puts "Analysing #{suffix}...".yellow

            total, scanned, file_count = Analyser.traverse(suffix, collect_count)
            puts "Traversed #{file_count} #{suffix} file(s)... 🎉".green
            ap scanned
            return unless collect_count.positive? && (total - collect_count).positive?

            puts "...and #{total - collect_count} more".yellow
          end
        end
      end
    end
  end
end
