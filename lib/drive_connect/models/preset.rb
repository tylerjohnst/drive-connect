require_relative 'base'
require_relative '../modules/dirty'

module DriveConnect::Models
  class Preset < Base

    include DriveConnect::Modules::Dirty

    field :id, type: Integer
    field :drive_id, type: Integer
    field :number
    field :name
    field :value
    field :created_at, type: Time
    field :updated_at, type: Time
  end
end
