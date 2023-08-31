# frozen_string_literal: true

module TailDraft
  module Util
    # Generator helper
    class Generator
      def self.random_class
        random = [*'A'..'Z'].sample(10).join.downcase
        "tail_draft:#{random}"
      end
    end
  end
end
