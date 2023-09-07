# frozen_string_literal: true

require 'windclutter/util/config'

module WindClutter
  # Analyser for windclutter
  class Analyser
    include WindClutter::Util

    def self.init(content)
      active_project = Config.read('active_project')

      class_key = Config.read_project(active_project, 'class_key')
      class_start = Config.read_project(active_project, 'class_start')
      class_end = Config.read_project(active_project, 'class_end')

      regex = /#{class_key}=#{class_start}(?:(?!windclutter:)[^#{class_end}])*#{class_end}/
      occurrence_regex = /#{class_key}=#{class_start}([^#{class_end}]*)#{class_end}/

      collections = {}
      content.scan(regex).each do |occurrence|
        cls = occurrence.to_s.match(occurrence_regex)[1].split(' ')

        cls.each do |c|
          total = collections[c].nil? ? 0 : collections[c]
          collections[c] = total + 1
        end
      end
      collections.sort_by { |_, v| -v }.to_h
    end
  end
end
