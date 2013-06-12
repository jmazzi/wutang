module Wutang
  class Config
    attr_reader :config_file, :attributes

    def initialize
      @config_file = File.expand_path('~/.wutang.yml')
      parse
    end

    def parse
      if File.world_readable?(config_file)
        puts "Your config file has world readable permissions"
        puts "Please run: chmod 640 ~/.wutang.yml"
        exit 1
      elsif File.exists?(config_file)
        @attributes = YAML.load_file(config_file)
      else
        puts "Please create a ~/.wutang.yml with a `path` and `pasphrase`"
        exit 1
      end
    end
  end
end
