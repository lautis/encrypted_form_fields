require 'test_helper'

class FormBuilderTest < MiniTest::Unit::TestCase
  def setup
    super
    @template = Object.new
    @template.extend ActionView::Helpers::FormHelper
    @template.extend ActionView::Helpers::FormOptionsHelper
    @object = Struct.new(:bar).new(SecureRandom.base64)
  end

  def test_encrypted_form_tag
    form_builder = ActionView::Helpers::FormBuilder.new(:foo, @object, @template, {})
    tag = HTML::Document.new(form_builder.encrypted_field(:bar)).find(tag: "input")
    decrypted_value = EncryptedFormFields.decrypt_and_verify(tag.attributes["value"])
    assert_equal @object.bar, decrypted_value
    assert_equal "_encrypted[foo][bar]", tag.attributes["name"]
    assert_equal "hidden", tag.attributes["type"]
    assert_equal "_encrypted_foo_bar", tag.attributes["id"]
  end
end
