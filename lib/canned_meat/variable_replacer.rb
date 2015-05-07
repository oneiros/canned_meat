module CannedMeat
  class VariableReplacer

    def initialize(variables, subscriber: nil)
      @variables = variables
      @subscriber = subscriber
    end

    def replace(template)
      template.dup.tap do |result|
        replace_static_variables(result)
        replace_subscriber_attributes(result) if @subscriber
      end
    end

    private

    def replace_static_variables(template)
      @variables.each do |name, value|
        template.gsub!("{{#{name}}}", value)
      end
    end

    def replace_subscriber_attributes(template)
      template.scan(/{{subscriber_(\w+)}}/)
        .flatten
        .uniq
        .map(&:to_sym)
        .each do |attribute|
          if @subscriber.respond_to? attribute
            template.gsub!("{{subscriber_#{attribute}}}", @subscriber.send(attribute))
          end
        end
    end
  end
end
