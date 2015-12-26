# frozen-string-literal: true
require "encrypted_form_fields/helpers/encrypted_field"

module EncryptedFormFields
  module Helpers
    module FormHelper
      # Returns a hidden and encrypted input tag for accessing a specified
      # attribute (identified by +method+) on an object assigned to the template
      # (identified by +object+).
      #
      # ==== Examples
      #   encrypted_field(:user, :email_verified_at)
      #   # => <input type="hidden" id="_encrypted_user_email_verified_at" name="_encrypted[user][email_verified_at]" value="#{encrypt(@user.email_verified_at})" />
      def encrypted_field(object_name, method, options = {})
        EncryptedField.new(object_name, method, self, options).render
      end
    end
  end
end
