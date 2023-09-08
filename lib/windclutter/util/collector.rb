# frozen_string_literal: true

def collect(collection, key, value)
  collection[key] ||= 0
  collection[key] = collection[key] + value
end
