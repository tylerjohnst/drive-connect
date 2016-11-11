module DriveConnect::Connectors
  class ConnectionFailed < ::StandardError
    attr_accessor :request

    def initialize(request)
      @request = request
    end
  end
end
