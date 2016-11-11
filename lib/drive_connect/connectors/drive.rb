module DriveConnect::Connectors
  class Drive

    attr_reader :director

    def initialize(http_adapter, drive, director)
      @drive = drive
      @director = director
      @http_adapter = http_adapter
    end

    def connection_options
      { host: host, path: path, body: body, token: token, port: port }
    end

    private

    def drive_path(addendum = nil)
      "/drives/#{@drive.remote_identifier}#{addendum}"
    end

    def token
      director.token
    end

    def host
      director.host
    end

    def port
      director.port.to_i
    end
  end
end
