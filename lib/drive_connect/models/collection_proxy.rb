require_relative '../modules/evented'

module DriveConnect::Models
  class CollectionProxy

    include DriveConnect::Modules::Evented
    include Enumerable

    def initialize(klass, options = {})
      @klass = klass
      @options = options
      @collection = []
    end

    def fetch!
      @_fetched_at = Time.now
      sql = DriveConnect::Store::SQLBuilder.new(@klass.resource_name).select('*')
      sql = sql.where(@options[:where]) if @options[:where]
      @collection = DriveConnect::Store::SQLite::Read.new(@klass, sql.to_sql).rows
      trigger(:fetch)
    end

    def each(&block)
      fetch! if fresh_collection?
      @collection.each(&block)
    end

    def length
      @collection.length
    end

    def [](index)
      @collection[index]
    end

    private

    def fresh_collection?
      @_fetched_at.nil?
    end

    def add_or_update(klass, record)
      if model = @collection.find { |model| model.id == record['id'] }
        model.reset(record)
      else
        @collection.push klass.new(record)
      end
    end
  end
end
