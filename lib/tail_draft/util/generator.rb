# frozen_string_literal: true

module TailDraft
  module Util
    # Generator helper
    class Generator
      def self.random_class
        random = [*'A'..'Z'].sample(6).join.downcase
        ".#{random}"
      end
    end
  end
end
