# frozen_string_literal: true

require 'fileutils'
require 'colorize'
require 'yaml'

module TailDraft
  module Util
    # Config handler
    class Config
      def self.update(key, value)
        return unless config_exists?

        config = YAML.load_file('/tmp/tail_draft/config.yml')
        config[key] = value

        File.open('/tmp/tail_draft/config.yml', 'w') { |f| YAML.dump(config, f) }
      end

      def self.read(key)
        return unless config_exists?

        config = YAML.load_file('/tmp/tail_draft/config.yml')
        config[key]
      end

      def self.config_exists?
        unless File.file?('/tmp/tail_draft/config.yml')
          puts 'You have not install tail_draft yet'.yellow
          puts 'To install, run:'
          puts "\ttail_draft install".green
          return false
        end
        true
      end
    end
  end
end
