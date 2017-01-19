# frozen-string-literal: true
require "action_controller"
require "action_view"
require "active_support/message_encryptor"

require "encrypted_form_fields/version"
require "encrypted_form_fields/dfs"
require "encrypted_form_fields/encrypted_parameters"
require "encrypted_form_fields/helpers/form_builder"
require "encrypted_form_fields/railtie" if defined?(Rails)

module EncryptedFormFields
  class << self
    def secret_key_base=(key)
      @encryptor = nil
      @secret_key_base = key
    end

    attr_reader :secret_key_base

    def secret_token=(key)
      @encryptor = nil
      @secret_token = key
    end

    attr_reader :secret_token

    def prefix_name(name)
      first, rest = name.split("[", 2)
      rest = "[" + rest if rest
      "_encrypted[#{first}]#{rest}"
    end

    delegate :encrypt_and_sign, :decrypt_and_verify, to: :encryptor

    # Decrypt encrypted parameters object
    def decrypt_parameters(params)
      Dfs.traverse(params || {}) do |value|
        EncryptedFormFields.decrypt_and_verify(value)
      end
    end

    # Encrypt hash values
    def encrypt_parameters(hash = {})
      Dfs.traverse(hash, &method(:encrypt_and_sign))
    end

    private

    def encryptor
      @encryptor ||= begin
        key = ActiveSupport::KeyGenerator.new(secret_token).generate_key(secret_key_base, 32)
        ActiveSupport::MessageEncryptor.new(key)
      end
    end
  end
end

ActionController::Base.send(:include, EncryptedFormFields::EncryptedParameters)
ActionView::Helpers::FormBuilder.send(:include, EncryptedFormFields::Helpers::FormBuilder)
