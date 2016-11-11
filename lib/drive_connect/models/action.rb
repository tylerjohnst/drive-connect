require_relative 'base'
require_relative '../constants'
require_relative '../modules/dirty'

module DriveConnect::Models
  class Action < Base

    include DriveConnect::Modules::Dirty

    field :id, type: Integer
    field :drive_id, type: Integer
    field :number
    field :occurrence, type: Enum, options: DriveConnect::ACTION_OCCURANCES
    field :on_time, type: Integer
    field :off_time, type: Integer
    field :on_action, type: Enum, options: DriveConnect::ACTION_OPTIONS
    field :off_action, type: Enum, options: DriveConnect::ACTION_OPTIONS
    field :created_at, type: Time
    field :updated_at, type: Time

    def on_action_code
      raw_attribute(:on_action)
    end

    def off_action_code
      raw_attribute(:off_action)
    end
  end
end
