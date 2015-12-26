# frozen-string-literal: true

module EncryptedFormFields
  module Helpers
    module FormTagHelper
      # Creates a hidden input field used with encrypted content. Use this field
      # to transmit data that user shouldn't see or be able to modify.
      #
      # ==== Options
      # * Creates standard HTML attributes for the tag.
      #
      # ==== Examples
      #   encrypted_field_tag 'email_verified_at', Time.now.to_s
      #   => <input id="email_verified_at" name="_encrypted_email_verified_at" type="hidden" value="[encrypted]" />
      def encrypted_field_tag(name, value = nil, options = {})
        encrypted_value = EncryptedFormFields.encrypt_and_sign(value)
        prefixed_name = EncryptedFormFields.prefix_name(name.to_s)
        tag :input, {
          "type" => "hidden",
          "name" => prefixed_name,
          "id" => sanitize_to_id(name),
          "value" => encrypted_value
        }.update(options.stringify_keys)
      end
    end
  end
end
