# frozen-string-literal: true
module EncryptedFormFields
  module Helpers
    module FormBuilder
      def encrypted_field(method, options = {})
        @template.encrypted_field(@object_name, method, objectify_options(options))
      end

      private

      def objectify_options(options)
        @default_options.merge(options.merge(object: @object))
      end
    end
  end
end
