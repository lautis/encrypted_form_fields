require "action_controller"
require "action_view"
require "active_support/message_encryptor"

require "encrypted_form_fields/version"
require "encrypted_form_fields/encrypted_parameters"
require "encrypted_form_fields/helpers/form_tag_helper"
require "encrypted_form_fields/helpers/form_helper"
require "encrypted_form_fields/helpers/form_builder"

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

    def prefix_name(name)
      first, rest = name.split("[", 2)
      rest = "[" + rest if rest
      "_encrypted[#{first}]#{rest}"
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
ActionView::Helpers::FormBuilder.send(:include, EncryptedFormFields::Helpers::FormBuilder)
ActionView::Helpers::FormHelper.send(:include, EncryptedFormFields::Helpers::FormHelper)
ActionView::Helpers::FormTagHelper.send(:include, EncryptedFormFields::Helpers::FormTagHelper)
