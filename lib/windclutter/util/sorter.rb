# frozen_string_literal: true

def sorter(collection)
  collection.sort_by { |_, v| -v }
end
