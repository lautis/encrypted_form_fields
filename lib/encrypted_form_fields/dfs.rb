module EncryptedFormFields
  module Dfs
    extend self

    def traverse(value, &block)
      if value.is_a?(Hash)
        traverse_hash(value, &block)
      elsif value.is_a?(Array)
        traverse_array(value, &block)
      else
        yield value
      end
    end

    private

    def traverse_hash(hash, &block)
      hash.inject({}.with_indifferent_access) do |result, (key, value)|
        result[key] = traverse(value, &block)
        result
      end
    end

    def traverse_array(array, &block)
      array.map do |value|
        traverse(value, &block)
      end
    end
  end
end
