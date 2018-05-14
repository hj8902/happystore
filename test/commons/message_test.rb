module MessageTest

    def message_for_type(type, options = {})
        message "errors.messages.#{type}", options
    end

    def message_for_attrubute(model, attribute)
        model.class.human_attribute_name(attribute)
    end

    def message(key, options = {})
        I18n.t(key, options)
    end
end