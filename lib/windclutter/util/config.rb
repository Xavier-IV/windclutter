# frozen_string_literal: true

require 'fileutils'
require 'colorize'
require 'yaml'

module WindClutter
  module Util
    # Config handler
    class Config
      def self.update(key, value)
        return unless config_exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')
        config[key] = value

        File.open('/tmp/windclutter/config.yml', 'w') { |f| YAML.dump(config, f) }
      end

      def self.setup_project(name)
        return unless config_exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')

        config['projects'][name] = {
          'project_path' => nil,
          'dump_path' => nil
        }

        File.open('/tmp/windclutter/config.yml', 'w') { |f| YAML.dump(config, f) }
      end

      def self.update_project(name, key, value)
        return unless config_exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')
        if config['projects'][name].nil?
          config['projects'][name] = {
            'project_path' => nil,
            'dump_path' => nil
          }
        end
        config['projects'][name][key] = value

        File.open('/tmp/windclutter/config.yml', 'w') { |f| YAML.dump(config, f) }
      end

      def self.read(key)
        return unless config_exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')
        config[key]
      end

      def self.wtf?
        return puts 'No config found.'.red unless config_exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')
        puts config
      end

      def self.config_exists?
        unless File.file?('/tmp/windclutter/config.yml')
          puts 'You have not install windclutter yet'.yellow
          puts 'To install, run:'
          puts "\twindclutter install".green
          return false
        end
        true
      end
    end
  end
end
