# frozen_string_literal: true

# stuff available to all forms
module FormHelper

  def error_message_on(object, method)
    return unless object.respond_to?(:errors) && object.errors.include?(method)

    errors = field_errors(object, method).join(', ')
    content_tag(:div, errors, class: 'field_with_errors')
  end

  private

  def field_errors(object, method)
    object.errors[method].map { |error| "#{method.to_s.humanize} #{error}" }
  end

end
