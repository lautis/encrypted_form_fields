# frozen-string-literal: true
require "test_helper"

class EncryptedParametersTest < MiniTest::Unit::TestCase
  def test_missing_encrypted_params
    controller = MockController.new({})
    assert_equal({}, controller.encrypted_params)
  end

  def test_invalid_encrypted_params
    controller = MockController.new("_encrypted" => { "key" => "value" })
    assert_raises ActiveSupport::MessageVerifier::InvalidSignature do
      controller.encrypted_params
    end
  end

  def test_properly_encrypted_params
    value = EncryptedFormFields.encrypt_and_sign("value")
    controller = MockController.new("_encrypted" => { "key" => value })
    assert_equal({ "key" => "value" }, controller.encrypted_params)

    controller = MockController.new("_encrypted" => { "key" => [value] })
    assert_equal({ "key" => ["value"] }, controller.encrypted_params)

    controller = MockController.new("_encrypted" => { "key" => { "nested" => value } })
    assert_equal({ "key" => { "nested" => "value" } }, controller.encrypted_params)
  end
end
