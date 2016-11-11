require_relative 'drive'

module DriveConnect::Connectors
  class DriveStatus < Drive

    def work!(&block)
      @http_adapter.get!(connection_options, &block)
    end

    def path
      drive_path + '/live'
    end

    def body
      {}
    end
  end
end
