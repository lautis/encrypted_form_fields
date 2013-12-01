module EncryptedFormFields
  module EncryptedParameters
    # Decrypt encrypted parameters
    def encrypted_params
      @encrypted_params ||= decrypt_value(params["_encrypted"] || {})
    end

    private

    def decrypt_array(array)
      array.map(&method(:decrypt_value))
    end

    def decrypt_hash(hash)
      hash.inject({}.with_indifferent_access) do |result, (key, value)|
        result[key] = decrypt_value(value)
        result
      end
    end

    def decrypt_value(value)
      if value.is_a?(Hash)
        decrypt_hash(value)
      elsif value.is_a?(Array)
        decrypt_array(value)
      else
        EncryptedFormFields.decrypt_and_verify(value)
      end
    end
  end
end
