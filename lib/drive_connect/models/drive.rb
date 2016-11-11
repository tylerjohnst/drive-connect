require_relative 'base'
require_relative '../modules/dirty'

module DriveConnect::Models
  class Drive < Base

    include DriveConnect::Modules::Dirty

    field :id, type: Integer
    field :director_id, type: Integer
    field :wizard_step, type: Integer
    field :name
    field :loop_type, type: Enum, options: DriveConnect::DRIVE_LOOP_TYPES
    field :ip_address
    field :port
    field :shell_command
    field :remote_identifier
    field :update_frequency
    field :is_provisioned, type: Boolean
    field :provisioned_at, type: Time
    field :serial_number
    field :system_mode
    field :motor_reference
    field :motor_horsepower, type: Float
    field :motor_voltage, type: Float
    field :motor_frequency
    field :motor_current, type: Float
    field :low_motor_speed, type: Integer
    field :high_motor_speed, type: Integer
    field :automatic_motor_speed, type: Enum, options: DriveConnect::DRIVE_AMA
    field :ramp_up_time, type: Float
    field :ramp_down_time, type: Float
    field :low_value, type: Float
    field :high_value, type: Float
    field :feedback_units
    field :last_synchronized_at, type: Time
    field :created_at, type: Time
    field :updated_at, type: Time

    def actions
      @actions ||= CollectionProxy.new(Action, where: [:drive_id, '=', self.id])
    end

    def presets
      @presets ||= CollectionProxy.new(Preset, where: [:drive_id, '=', self.id])
    end
  end
end
