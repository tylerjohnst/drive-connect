require_relative 'drive'

module DriveConnect::Connectors
  class DriveConfiguration < Drive

    def work!(&block)
      @http_adapter.put!(connection_options, &block)
    end

    def body
      DriveConnect::Serializers::DriveConfiguration.new(@drive).to_json
    end

    def path
      drive_path
    end
  end
end
