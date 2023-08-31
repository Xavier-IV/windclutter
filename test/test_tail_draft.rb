# frozen_string_literal: true

require 'minitest/autorun'

Dir['test/tail_draft/**/*.rb'].sort.each { |f| require f.split('/')[1..].join('/') }
