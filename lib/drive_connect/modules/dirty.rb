module DriveConnect
  module Modules
    module Dirty
      def self.included(base)
        base.class_eval do
          field :modified_at, type: Time
        end
      end

      def write_attribute(name, value)
        old_value = read_attribute(name)
        super
        new_value = read_attribute(name)
        flag_dirty if old_value != new_value
      end

      def flag_dirty
        self.modified_at = Time.now
      end
    end
  end
end
