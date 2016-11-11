module DriveConnect::Store
  class SQLBuilder

    def initialize(table_name)
      @table_name = table_name
      @query = {}
    end

    def select(*fields)
      Select.new(@table_name, select: fields)
    end

    def insert(values)
      Insert.new(@table_name, values)
    end

    def update(*args)
      values = args.pop
      Update.new(@table_name, where: args, values: values)
    end

    class Query
      attr_reader :table_name, :options

      def initialize(table_name, options)
        @table_name = table_name
        @options    = options
      end

      def to_sql
        [ query, bindings ]
      end

      private

      def where_clause
        return '' if where_attributes.empty?
        ' WHERE ' + where_attributes.map do |query|
          if query.length == 1
            query.first
          else
            column, operator, value = query
            comparitor(column, operator)
          end
        end.join
      end

      def where_attributes
        options[:where] || []
      end

      def quoted_table_name
        quote table_name
      end

      def comparitor(column, operator)
        "#{quoted_table_name}.#{quote column} #{operator} ?"
      end

      def quote(string)
        "\"#{string}\""
      end
    end


    class Select < Query

      def where(*clauses)
        options[:where] ||= clauses
        return self
      end

      private

      def query
        "SELECT #{quote table_name}.* FROM #{quote table_name}" + where_clause
      end

      def bindings
        where_attributes.map(&:last)
      end
    end

    class Insert < Query

      private

      def query
        "INSERT INTO #{quoted_table_name} (#{quoted_keys}) VALUES (#{placeholders})"
      end

      def bindings
        options.values
      end

      def quoted_keys
        keys.map(&method(:quote)).join(', ')
      end

      def keys
        options.keys
      end

      def placeholders
        ( ['?'] * keys.length ).join(', ')
      end
    end

    class Update < Query

      private

      def query
        ["UPDATE #{quoted_table_name} SET ", update_clause, where_clause].join
      end

      def bindings
        values_attributes.values.concat where_attributes.map(&:last)
      end

      def values_attributes
        options[:values] || {}
      end

      def update_clause
        values_attributes.map { |column, value| %Q{"#{column}" = ?} }.join(', ')
      end
    end
  end
end
