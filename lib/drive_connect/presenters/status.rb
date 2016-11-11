require_relative 'base'

module DriveConnect::Presenters
  class Status < Base
    def cost_savings
      payload.data.payload.cost_savings
    end

    def flow_rate
      payload.data.flow_rate
    end

    def heat_sink_temp
      payload.data.heat_sink_temp.gsub(/ deg/i, '&deg;').html_safe
    end

    def pump_pressure
      payload.data.pump_pressure
    end

    private

    def payload
      model.payload_as_object
    end
  end
end
