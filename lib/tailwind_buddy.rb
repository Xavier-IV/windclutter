# frozen_string_literal: true

###
#
class TailwindBuddy
  # Say hi to the world!
  #
  # Example:
  #   >> TailwindBuddy.hi("spanish")
  #   => hola mundo
  #
  # Arguments:
  #   language: (String)

  def self.hi(language = 'english')
    translator = Translator.new(language)
    translator.hi
  end
end

require 'tailwind_buddy/translator'
