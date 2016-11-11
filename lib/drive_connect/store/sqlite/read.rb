module DriveConnect::Store
  module SQLite
    class Read

      DATA_TYPES = {
        Time    => ->(value) { value },
        String  => ->(value) { value },
        Enum    => ->(value) { value },
        Integer => ->(value) { value },
        Float   => ->(value) { value },
        Boolean => ->(value) { value == 1 ? true : false },
      }

      def initialize(model_klass, sql_query)
        @model_klass = model_klass
        @sql_query = sql_query
      end

      def rows
        connection.execute(*@sql_query).map do |row|
          @model_klass.new deserialize_row(row)
        end
      end

      def deserialize_row(row)
        {}.tap do |hash|
          row.each do |key, value|
            field = @model_klass.fields[key.to_s]
            hash[key.to_s] = deserialize(field, value) if field
          end
        end
      end

      def model_fields
        @model_fields ||= @model_klass.fields.keys
      end

      private

      def connection
        DriveConnect::Store::Database.new
      end

      def deserialize(field, value)
        type = field[:type]
        DATA_TYPES[type].call(value)
      end
    end
  end
end
