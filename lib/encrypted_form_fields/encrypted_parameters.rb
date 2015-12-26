# frozen-string-literal: true

module EncryptedFormFields
  module EncryptedParameters
    # Decrypt encrypted parameters
    def encrypted_params
      @encrypted_params ||=
        EncryptedFormFields.decrypt_parameters(params["_encrypted"] || {})
    end
  end
end
