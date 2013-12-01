require "action_controller"
require "active_support/message_encryptor"

require "encrypted_form_fields/version"
require "encrypted_form_fields/encrypted_parameters"

module EncryptedFormFields
  class << self
    def secret_key_base=(key)
      @encryptor = nil
      @secret_key_base = key
    end

    def secret_key_base
      @secret_key_base
    end

    def secret_token=(key)
      @encryptor = nil
      @secret_token = key
    end

    def secret_token
      @secret_token
    end

    delegate :encrypt_and_sign, :decrypt_and_verify, to: :encryptor

    private

    def encryptor
      @encryptor ||= begin
        key = ActiveSupport::KeyGenerator.new(secret_token).generate_key(secret_key_base)
        ActiveSupport::MessageEncryptor.new(key)
      end
    end
  end
end

ActionController::Base.send(:include, EncryptedFormFields::EncryptedParameters)
