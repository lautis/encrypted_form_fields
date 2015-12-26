# frozen-string-literal: true
module EncryptedFormFields
  module Dfs
    extend self

    def traverse(value, &block)
      if value.respond_to?(:each_pair)
        traverse_hash(value, &block)
      elsif value.is_a?(Array)
        traverse_array(value, &block)
      else
        yield value
      end
    end

    private

    def traverse_hash(hash, &block)
      result = {}.with_indifferent_access
      hash.each_pair do |key, value|
        result[key] = traverse(value, &block)
      end
      result
    end

    def traverse_array(array, &block)
      array.map do |value|
        traverse(value, &block)
      end
    end
  end
end
