# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require 'mocha/minitest'

Dir['test/fixtures/**/*.rb'].sort.each { |f| require f.split('/')[1..].join('/') }
Dir['test/windclutter/**/*.rb'].sort.each { |f| require f.split('/')[1..].join('/') }
