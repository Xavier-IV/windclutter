# frozen_string_literal: true

require 'windclutter/util/collector'
require 'windclutter/util/config'
require 'windclutter/util/sorter'
require 'windclutter/util/file_handler'

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

        cls.each { |k| collect(collections, k, 1) }
      end
      sorter(collections).to_h
    end

    def self.traverse(suffix, limit)
      collection = {}
      scanned = FileHandler.scanners(suffix)
      scanned.each do |file|
        init(File.open(file).read).each { |k, v| collect(collection, k, v) }
      end

      sorted = sorter(collection)
      result = limit.positive? ? sorted.to_h : sorted.first(limit).to_h

      [sorted.count, result, scanned.count]
    end
  end
end
