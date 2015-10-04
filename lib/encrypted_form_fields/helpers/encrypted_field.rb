require "action_view/helpers/tags/hidden_field"

module EncryptedFormFields
  module Helpers
    class EncryptedField < ActionView::Helpers::Tags::HiddenField
      def initialize(object_name, method_name, template_object, options = {})
        super(object_name, method_name, template_object, options.dup)
        value = @options.with_indifferent_access.fetch("value") { value_before_type_cast(object) }
        @options["value"] = EncryptedFormFields.encrypt_and_sign(value)
        @object_name = EncryptedFormFields.prefix_name(@object_name)
      end

      class << self
        def field_type
          "hidden"
        end
      end
    end
  end
end
