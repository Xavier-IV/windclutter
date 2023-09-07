# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'windclutter'
  s.version = '0.0.5'
  s.summary = 'Quickly develop with TailwindCSS without worries.'
  s.description = 'Your buddy to skyrocket your development with TailwindCSS.'
  s.authors = ['Zafranudin Zafrin']
  s.email = 'coffee@zafranudin.dev'
  s.files = Dir['{lib}/**/*.rb', '{lib}/template/**/*.yml', 'bin/*', 'test/**/*.rb', 'LICENSE', '*.md']
  s.homepage = 'https://rubygems.org/gems/tailwind_buddy'
  s.license = 'MIT'
  s.required_ruby_version = '>= 2.7.0'
  s.executables << 'windclutter'
end
