# frozen-string-literal: true
require "test_helper"
require "nokogiri"
require "encrypted_form_fields/helpers/form_tag_helper"

class FormTagHelperTest < ActionView::TestCase
  tests EncryptedFormFields::Helpers::FormTagHelper

  def test_encrypted_form_tag
    document = Nokogiri::HTML.fragment(encrypted_field_tag("field", "value"))
    tag = document.css("input").first
    decrypted_value = EncryptedFormFields.decrypt_and_verify(tag.attributes["value"].value)
    assert_equal "value", decrypted_value
    assert_equal "_encrypted[field]", tag.attributes["name"].value
    assert_equal "hidden", tag.attributes["type"].value
    assert_equal "field", tag.attributes["id"].value
  end

  def test_symbol_form_field_name
    document = Nokogiri::HTML.fragment(encrypted_field_tag(:field, "value"))
    tag = document.css("input").first
    EncryptedFormFields.decrypt_and_verify(tag.attributes["value"].value)
    assert_equal "_encrypted[field]", tag.attributes["name"].value
  end
end
