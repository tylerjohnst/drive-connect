module DriveConnect
  module Modules
    module Evented
      def on(event_name, method_reference)
        __observers__(event_name) << method_reference
        return nil
      end

      def off(event_name, method_reference)
        __observers__(event_name).delete_if { |m| m == method_reference }
        return nil
      end

      def trigger(event_name, *args)
        __observers__(event_name).each do |block|
          block.call(*args)
        end
      end

      def __observers__(event_name)
        @__observers__ ||= {}
        @__observers__[event_name] ||= []
      end
    end
  end
end
