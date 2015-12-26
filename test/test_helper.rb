# frozen-string-literal: true
ENV["RAILS_ENV"] = "test"
require "minitest/autorun"
require "minitest/pride"
require "securerandom"
require "encrypted_form_fields"

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

if ActiveSupport::TestCase.respond_to?(:test_order=)
  ActiveSupport::TestCase.test_order = :random
end

MockController.send(:include, EncryptedFormFields::EncryptedParameters)
