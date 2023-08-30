require "thor"

class TailDraft
  ###
  #
  class CLI < Thor
    desc "hello NAME", "say hello to NAME"
    option :from
    def hello(name)
      puts "from: #{options[:from]}" if options[:from]
      puts "Hello #{name}"
    end
  end
end
