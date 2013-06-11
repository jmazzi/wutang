module Wutang
  class Interface
    attr_reader :persistence

    def initialize(path, passphrase)
      @persistence = Persistence.new(path, passphrase)
    end

    def entries
      persistence.all
    end

    def create(attributes)
      Entry.new(attributes, Persistence.generate_filename).tap do |entry|
        persistence.write entry.path, entry.as_json
      end
    end

    def update(entry, updates)
      entry.tap do
        entry.attributes.merge! updates
        persistence.write entry.path, entry.as_json
      end
    end

    def search(criteria)
      entries.select do |entry|
        attributes = entry.attributes
        attributes.keys.any? { |key| attributes[key] =~ /#{criteria}/ }
      end
    end

    def find(entry_id)
      entries.detect { |entry| entry.path == entry_id }
    end
  end
end
