# frozen_string_literal: true

require 'fileutils'
require 'colorize'
require 'yaml'

module WindClutter
  module Util
    # Config handler
    class Config
      def self.update(key, value)
        return unless exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')
        config[key] = value

        File.open('/tmp/windclutter/config.yml', 'w') { |f| YAML.dump(config, f) }
      end

      def self.setup_project(name)
        return unless exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')

        config['projects'][name] = {
          'project_path' => nil,
          'dump_path' => nil,
          'class_key' => 'class',
          'class_start' => '"',
          'class_end' => '"'
        }

        File.open('/tmp/windclutter/config.yml', 'w') { |f| YAML.dump(config, f) }
      end

      def self.update_project(name, key, value)
        return unless exists?

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

      def self.read_project(name, key)
        return unless exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')
        config['projects'][name][key]
      end

      def self.read(key)
        return unless exists?

        config = YAML.load_file('/tmp/windclutter/config.yml')
        config[key]
      end

      def self.wtf?
        return puts 'No config found.'.red unless exists?

        YAML.load_file('/tmp/windclutter/config.yml')
      end

      def self.exists?
        File.file?('/tmp/windclutter/config.yml')
      end
    end
  end
end
