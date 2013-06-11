module Wutang
  class Entry
    attr_reader :attributes, :path

    def initialize(attributes, path)
      @attributes = attributes
      @path       = path
    end

    def [](key)
      attributes[key]
    end

    def []=(key, value)
      attributes[key] = value
    end

    def as_json
      attributes
    end

    def to_s
      attributes.merge(id: path).to_s
    end
  end
end
