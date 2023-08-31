# frozen_string_literal: true

module TailDraft
  # Processor for tail_draft
  class Processor
    def self.build_single(name, classes)
      <<~OUTPUT
        #{name} {
          @apply #{classes.join(' ')};
        }
      OUTPUT
    end

    def self.sort(classes)
      classes.sort
    end
  end
end
