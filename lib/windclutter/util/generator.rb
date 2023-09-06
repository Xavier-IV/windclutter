# frozen_string_literal: true

module WindClutter
  module Util
    # Generator helper
    class Generator
      def self.random_class(prefixed: true)
        random = [*'A'..'Z'].sample(10).join.downcase
        "windclutter:#{random}" if prefixed
        random
      end
    end
  end
end
