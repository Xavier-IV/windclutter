# frozen_string_literal: true

require 'thor'
require 'fileutils'
require 'tail_draft/processor'
require 'tail_draft/util/generator'

module TailDraft
  # CLI implementation for tail_draft
  class CLI < Thor
    attr_reader :config_folder

    option :name

    def initialize(args = nil, options = nil, config = nil)
      @config_folder = '/tmp/tail_draft'
      super
    end

    # Init your project with tail_draft
    #
    #    TailDraft::CLI.init(<project_name>)
    desc 'init PROJECT_NAME', 'The name of your project'
    def init(name)
      create_project(name)
    end

    # Draft the list of classes
    #
    #    TailDraft::CLI.draft(<tailwind class_names>)
    desc 'draft CLASS_NAMES', 'Provide a list of class'
    def draft(*class_names)
      name = options[:name]
      name = TailDraft::Util::Generator.random_class if name.to_s.empty?

      classes = TailDraft::Processor.sort(class_names)
      TailDraft::Processor.build_single(name, classes)
    end

    private

    def create_project(_value)
      FileUtils.mkdir_p(@config_folder)
      nil
    end
  end
end
