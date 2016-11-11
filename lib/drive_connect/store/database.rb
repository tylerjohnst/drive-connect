module DriveConnect::Store
  class Database

    COLUMNS = {
      Time    => 'varchar(100)',
      String  => 'varchar(255)',
      Enum    => 'integer',
      Integer => 'integer',
      Float   => 'real',
      Boolean => 'integer',
    }

    class << self
      attr_accessor :path_to_database
    end

    def initialize(path = nil)
      @path = path || self.class.path_to_database
      @connection = build_connection
      load_schema!
    end

    def number_of_tables
      count = execute("SELECT count(*) FROM sqlite_master WHERE type = 'table' AND name != 'sqlite_sequence'").first
      return count['count(*)'] || count[:'count(*)']
    end

    def load_schema!
      return if number_of_tables > 0
      create_table DriveConnect::Models::Director
      create_table DriveConnect::Models::Drive
      create_table DriveConnect::Models::Action
      create_table DriveConnect::Models::Preset
    end

    def execute(*args)
      @connection.execute(*args)
    end

    private

    def create_table(klass)
      execute "create table #{klass.resource_name} ( #{sql_for_create_table(klass)} );"
    end

    def sql_for_create_table(klass)
      klass.fields.map do |name, field|
        "#{name} #{column_type_for_field(field)}"
      end.join(', ')
    end

    def column_type_for_field(field)
      COLUMNS[field[:type]]
    end

    def build_connection
      SQLite3::Database.new(@path).tap do |db|
        # Tell ruby-sqlite3 to act like motion-sqlite3
        db.results_as_hash = true if db.respond_to?(:results_as_hash)
      end
    end
  end
end
