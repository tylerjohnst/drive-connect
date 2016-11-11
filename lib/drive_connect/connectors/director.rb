module DriveConnect::Connectors
  class Director

    DEFAULT_TOKEN = '07a7e54dfc97b407cb3f0ba095cdf7fd'

    def initialize(http_adapter, director)
      @http_adapter = http_adapter
      @director = director
    end

    def work!(&block)
      @http_adapter.post!(connection_options, &block)
    end

    def connection_options
      { host: host, path: path, body: body, token: token, port: port }
    end

    private

    def token
      @director.is_provisioned ? @director.token : DEFAULT_TOKEN
    end

    def body
      DriveConnect::Serializers::Director.new(@director).to_json
    end

    def path
      '/director'
    end

    def host
      @director.host
    end

    def port
      @director.port.to_i
    end
  end
end
