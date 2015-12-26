# frozen-string-literal: true
require "encrypted_form_fields/helpers/form_tag_helper"
require "encrypted_form_fields/helpers/form_helper"

module EncryptedFormFields
  class Railtie < Rails::Railtie
    initializer "encrypted_form_fields.view_helpers" do
      ActionView::Base.send(:include, EncryptedFormFields::Helpers::FormHelper)
      ActionView::Base.send(:include, EncryptedFormFields::Helpers::FormTagHelper)
    end
  end
end
