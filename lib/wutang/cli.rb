module Wutang
  class Cli
    attr_reader :command, :args, :wutang

    def initialize(wutang)
      @command = ARGV.shift.to_sym
      @args    = ARGV
      @wutang  = wutang
    end

    def handle
      case command
      when :create
        entry = wutang.create attributes
        puts "Created #{entry}"
      when :update
        if entry = wutang.find(args.shift)
          wutang.update entry, attributes
          puts "Entry updated with the following changes: #{attributes}"
        else
          puts "Entry not found"
        end
      when :search
        criteria = args.shift
        puts wutang.search criteria
      when :list
        puts wutang.entries
      else
        puts "Unknown command #{command}"
      end
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
