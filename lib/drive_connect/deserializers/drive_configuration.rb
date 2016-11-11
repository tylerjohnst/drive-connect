module DriveConnect::Deserializers
  class DriveConfiguration
    def initialize(drive, actions, payload)
      @drive = drive
      @actions = actions
      @payload = payload
    end

    def attributes
      Hash.new.tap do |hash|
        hash[:low_motor_speed] = @payload['0411_motor_speed_low_limit_rpm'].to_i
        hash[:high_motor_speed] = @payload['0413_motor_speed_high_limit_rpm'].to_i
        hash[:actions_attributes] = parse_timed_actions
      end
    end

    private

    def timed_action(number)
      action_model   = action(number + 1)
      action_payload = payload_actions[number.to_s]

      Hash.new.tap do |hash|
        hash['id'] = action_model.id
        hash['on_time']    = action_payload['2300_on_time']
        hash['on_action']  = action_payload['2301_on_action'].to_i
        hash['occurrence'] = action_payload['2304_occurrence'].to_i
        hash['off_time']   = action_payload['2302_off_time']
        hash['off_action'] = action_payload['2303_off_action'].to_i
      end
    end

    def parse_timed_actions
      (0..7).each_with_object(Hash.new) do |i, hash|
        hash[i.to_s] = timed_action(i)
      end
    end

    def action(number)
      @actions.to_a.find { |action| action.number.to_s == number.to_s }
    end

    def payload_actions
      @payload['timed_actions']
    end
  end
end
