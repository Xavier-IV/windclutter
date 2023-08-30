# frozen_string_literal: true

require 'thor'

module TailDraft
  ###
  #
  class CLI < Thor
    option :to
    desc 'draft CLASS_NAMES', 'Provide a list of class'
    def draft(*class_names)
      to = options[:to]
      if !options[:to] && options[:to].to_s.empty?
        say 'Provide class name now (.class|.class.child)?', :green
        to = ask 'You can always do this later:', :bold
      end

      return unless to

      output_class(to, class_names)
    end

    def output_class(to, class_names)
      puts <<~OUTPUT
        CSS Class
        #{to} {
          @apply #{class_names.join(' ')};
        }
      OUTPUT
    end
  end
end
