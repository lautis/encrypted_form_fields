# frozen-string-literal: true
require "action_view/helpers/tags/hidden_field"

module EncryptedFormFields
  module Helpers
    class EncryptedField < ActionView::Helpers::Tags::HiddenField
      class << self
        def field_type
          "hidden"
        end
      end

      def initialize(object_name, method_name, template_object, options = {})
        super(object_name, method_name, template_object, options.dup)
        value = @options.with_indifferent_access.fetch("value") do
          encrypted_field_value_before_type_cast(object)
        end
        @options["value"] = EncryptedFormFields.encrypt_and_sign(value)
        @object_name = EncryptedFormFields.prefix_name(@object_name)
      end

      private


      def encrypted_field_value_before_type_cast(object)
        if method(:value_before_type_cast).arity.zero?
          value_before_type_cast
        else
          # Fallbackf for Rails < 5.2
          value_before_type_cast(object)
        end
      end
    end
  end
end
