require_relative '../modules/evented'

module DriveConnect::Models
  class Base

    DESERIALIZERS = {
      Time    => ->(value, field) { Time.parse(value.to_s) },
      String  => ->(value, field) { value.to_s },
      Enum    => ->(value, field) { field[:options][value.to_i] },
      Integer => ->(value, field) { value.to_i },
      Float   => ->(value, field) { value.to_s.to_f },
      Boolean => ->(value, field) { value }
    }

    SERIALIZERS = {
      Time    => ->(value, field) { value.to_s },
      String  => ->(value, field) { value.to_s },
      Enum    => ->(value, field) { value.is_a?(Integer) ? value : field[:options].index(value) },
      Integer => ->(value, field) { value },
      Float   => ->(value, field) { value.to_s.to_f },
      Boolean => ->(value, field) { value }
    }

    class << self

      def fields
        @fields ||= {}
      end

      def field(name, options = {})
        fields[name.to_s] = { type: String }.merge(options)

        define_method "#{name}" do
          read_attribute(name.to_s)
        end

        define_method "#{name}=" do |value|
          write_attribute(name.to_s, value)
        end
      end

      def resource_name
        self.to_s.split('::').last.downcase + 's'
      end
    end

    include DriveConnect::Modules::Evented

    attr_reader :attributes
    attr_reader :observers

    def initialize(attributes = {})
      @attributes = attributes
      @observers  = {}
    end

    def update_attributes(attributes)
      attributes.each do |field, value|
        public_send("#{field}=", value) if respond_to?("#{field}=")
      end

      persist!
    end

    def save
      persist!
    end

    def read_attribute(name)
      field = self.class.fields[name.to_s]
      value = @attributes[name.to_s]
      deserialize(field, value)
    end

    def raw_attribute(name)
      @attributes[name.to_s]
    end

    def write_attribute(name, value)
      field = self.class.fields[name.to_s]
      @attributes[name.to_s] = serialize(field, value)
    end

    def reset(attributes)
      @attributes = attributes
    end

    private

    def persist!
      DriveConnect::Store::SQLite::Write.new(self).persist!
    end

    def serialize(field, value)
      klass = field[:type]
      SERIALIZERS[klass].call(value, field)
    end

    def deserialize(field, value)
      return nil if value.nil? || value == ''
      klass = field[:type]
      DESERIALIZERS[klass].call(value, field)
    end
  end
end
