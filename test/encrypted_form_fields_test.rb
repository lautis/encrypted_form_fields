# frozen-string-literal: true
require "test_helper"

class EncryptedFormFieldsTest < MiniTest::Unit::TestCase
  def test_encrypting_parameters
    hash = EncryptedFormFields.encrypt_parameters("foo" => "bar")
    decrypted = EncryptedFormFields.decrypt_and_verify(hash["foo"])
    assert_equal("bar", decrypted)
  end

  def test_decrypting_parameters
    value = EncryptedFormFields.encrypt_and_sign("bar")
    hash = EncryptedFormFields.decrypt_parameters("foo" => { "0" => value })
    assert_equal("bar", hash["foo"]["0"])
  end
end
