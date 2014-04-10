require 'yaml'

module Chem
  ELEMENTS_YAML = YAML.load_file(File.expand_path('../elements.yml', __FILE__))

  class Element
    attr_reader :atomic_number
    attr_reader :name
    attr_reader :symbol

    def self.all
      ELEMENTS_YAML.map do |symbol, attributes|
        new(attributes.merge(symbol: symbol))
      end
    end

    def self.find(symbol)
      result = ELEMENTS_YAML.find do |sym, _|
        symbol.to_s.eql? sym
      end

      if result
        attributes = result.last
        new(attributes.merge(symbol: symbol))
      else
        fail ArgumentError, "Unknown chemical symbol '#{symbol}'"
      end
    end

    def initialize(attributes)
      attributes.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def to_sym
      symbol.to_sym
    end
  end
end
