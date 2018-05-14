require 'test_helper'
require 'commons/message_test'

class ApplicationTest < ActiveSupport::TestCase
    include MessageTest

    def do_not_have_attribute(entity, type, attribute, attribute_key = nil)
        attribute_name = message_for_attrubute(entity, attribute)
        expected_message = message_for_type(type, { attribute: attribute_name })
        
        attribute_key = attribute_key || attribute
        entity[attribute_key] = nil

        exception = assert_raise ActiveRecord::RecordInvalid do
            entity.save!
        end

        assert_not exception.nil?

        assert_equal exception.message, expected_message
        assert_equal entity.errors.messages[attribute].first, expected_message
    end
end