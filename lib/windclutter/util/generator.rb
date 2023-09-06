# frozen_string_literal: true

module WindClutter
  module Util
    # Generator helper
    class Generator
      def self.random_class
        random = [*'A'..'Z'].sample(10).join.downcase
        "windclutter:#{random}"
      end
    end
  end
end
