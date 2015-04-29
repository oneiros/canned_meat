module CannedMeat
  class VariableReplacer

    def initialize(template)
      @template = template
    end

    def replace(variables, subscriber: nil)
      @template.dup.tap do |result|
        replace_static_variables(result, variables)
        replace_subscriber_attributes(result, subscriber) if subscriber
      end
    end

    private

    def replace_static_variables(template, variables)
      variables.each do |name, value|
        template.gsub!("{{#{name}}}", value)
      end
    end

    def replace_subscriber_attributes(template, subscriber)
      template.scan(/{{subscriber_(\w+)}}/)
        .flatten
        .uniq
        .map(&:to_sym)
        .each do |attribute|
          if subscriber.respond_to? attribute
            template.gsub!("{{subscriber_#{attribute}}}", subscriber.send(attribute))
          end
        end
    end
  end
end
