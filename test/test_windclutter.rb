# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/mock'
require 'mocha/minitest'
require 'mocha'
require 'simplecov'
SimpleCov.start do
  add_filter '/test/'
  add_filter '/template/'
  add_filter '/lib/windclutter/cli'
end

Dir['test/fixtures/**/*.rb'].sort.each { |f| require f.split('/')[1..].join('/') }
Dir['test/windclutter/**/*.rb'].sort.each { |f| require f.split('/')[1..].join('/') }
