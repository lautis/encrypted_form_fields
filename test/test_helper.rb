ENV['RAILS_ENV'] = 'test'
require 'minitest/unit'
require 'minitest/autorun'
require 'minitest/pride'
require 'securerandom'
require 'encrypted_form_fields'

EncryptedFormFields.secret_key_base = SecureRandom.hex
EncryptedFormFields.secret_token = SecureRandom.hex

class MockController
  attr_accessor :request

  def initialize(params = {})
    @params = params
  end

  def params
    ActionController::Parameters.new(@params)
  end
end

MockController.send(:include, EncryptedFormFields::EncryptedParameters)
