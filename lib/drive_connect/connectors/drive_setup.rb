require_relative 'drive'

module DriveConnect::Connectors
  class DriveSetup < Drive

    def work!(&block)
      if is_update?
        @http_adapter.put!(connection_options, &block)
      else
        @http_adapter.post!(connection_options, &block)
      end
    end

    private

    def is_update?
      @drive.is_provisioned == true
    end

    def body
      DriveConnect::Serializers::DriveSetup.new(@drive).to_json
    end

    def path
      is_update? ? drive_path('/config') : "/drives"
    end
  end
end
