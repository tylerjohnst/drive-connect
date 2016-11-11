require_relative '../modules/evented'
require_relative 'database'
require_relative 'sql_builder'
require_relative 'sqlite/read'

module DriveConnect::Store
  class Sync

    include DriveConnect::Modules::Evented

    class << self
      attr_accessor :http_adapter, :is_connected
    end

    def initialize(klass)
      @klass = klass
      @database = Database.new
    end

    def sync!
      upload! do |records, error|
        persist!(records) unless error
        trigger(:done)
      end
    end

    def upload!(&block)
      self.class.http_adapter.request!(:post, "bulk/#{resource_name}", payload, &block)
    end

    def payload
      { records: dirty_records.map(&:attributes) }
    end

    def dirty_records
      sql = DriveConnect::Store::SQLBuilder.new(resource_name).select('*').where([:modified_at, '<>', '""'])
      DriveConnect::Store::SQLite::Read.new(@klass, sql.to_sql).rows
    end

    def resource_name
      @klass.resource_name
    end

    def persist!(records)
      @database.execute("delete from #{resource_name}")
      records.each { |record| SQLite::Write.new(@klass.new record).persist! }
    end
  end
end
