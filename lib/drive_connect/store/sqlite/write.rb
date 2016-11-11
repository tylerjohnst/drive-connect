module DriveConnect::Store
  module SQLite
    class Write

      DATA_TYPES = {
        Time    => ->(value) { value.to_s },
        String  => ->(value) { value.to_s },
        Enum    => ->(value) { value.to_i },
        Integer => ->(value) { value.to_i },
        Float   => ->(value) { value.to_f },
        Boolean => ->(value) { value == true ? 1 : 0 },
      }

      def initialize(model)
        @model = model
      end

      def persist!
        query = sql.to_sql
        connection.execute(*query)
      end

      def attributes
        {}.tap do |hash|
          @model.class.fields.each do |name, field|
            hash[name.to_s] = serialize(field, @model.attributes[name.to_s])
          end
        end
      end

      def sql
        builder = SQLBuilder.new(table_name)

        if record_exists?
          without_id = attributes.delete_if { |k, v| k.to_s == 'id' }
          builder.update(where_clause, without_id)
        else
          builder.insert(attributes)
        end
      end

      def table_name
        @model.class.resource_name
      end

      def connection
        @connection ||= DriveConnect::Store::Database.new
      end

      private

      def record_exists?
        sql = DriveConnect::Store::SQLBuilder.new(table_name).select('*').where(where_clause)
        connection.execute(*sql.to_sql).length > 0
      end

      def serialize(field, value)
        type = field[:type]
        DATA_TYPES[type].call(value)
      end

      def where_clause
        ['id', '=', @model.id]
      end
    end
  end
end
