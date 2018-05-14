module ModelError
    extend ActiveSupport::Concern

    module ClassMethods
        def error(type, options)
            options = { attribute: options } if options.is_a?(String) || options.is_a?(Symbol)
            options[:attribute] = attribute_name(options[:attribute]) if options.is_a?(Hash) && options[:attribute]

            I18n.t("errors.messages.#{type}", options)
        end

        def attribute_name(attribute)
            self.human_attribute_name(attribute)
        end
    end

end