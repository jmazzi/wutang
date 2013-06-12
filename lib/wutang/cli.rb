module Wutang
  class Cli
    PUBLIC_COMMANDS = [:create, :update, :search, :list]
    attr_reader :command, :args, :wutang

    def initialize(wutang)
      @command = ARGV.shift.to_s.to_sym
      @args    = ARGV
      @wutang  = wutang
    end

    def handle
      if PUBLIC_COMMANDS.include?(command)
        send(command)
      else
        puts "Unknown command #{command}"
      end
    end

    def create
      entry = wutang.create attributes
      puts "Created #{entry}"
    end

    def update
      if entry = wutang.find(args.shift)
        wutang.update entry, attributes
        puts "Entry updated with the following changes: #{attributes}"
      else
        puts "Entry not found"
      end
    end

    def search
      criteria = args.shift
      puts wutang.search criteria
    end

    def list
      puts wutang.entries
    end

    def attributes
      {}.tap do|hash|
        args.each do |arg|
          key, value       = arg.split(':')
          hash[key.to_sym] = value
        end
      end
    end
  end
end
