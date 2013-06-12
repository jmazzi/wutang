module Wutang
  class Persistence
    attr_reader :path, :crypto

    def initialize(path, passphrase)
      @path   = File.expand_path(path)
      @crypto = Encryption.new(passphrase)
      Dir.mkdir(@path) unless File.exists?(@path)
    end

    def read(filename)
      data      = IO.read("#{path}/#{filename}.json")
      plaintext = crypto.decrypt(data)

      JSON.parse(plaintext, symbolize_names: true)
    end

    def write(filename, content)
      File.open("#{path}/#{filename}.json", "w") do |f|
        ciphertext = crypto.encrypt(content.to_json)
        f.write ciphertext
      end
    end

    def all
      files.map do |file|
        content = read(file)
        Entry.new(content, file)
      end
    end

    private

    def files
      Dir["#{path}/*.json"].map { |f| File.basename(f, '.json') }
    end

    def self.generate_filename
      "#{SecureRandom.uuid}"
    end
  end
end
