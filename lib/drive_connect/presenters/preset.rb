require_relative 'base'

module DriveConnect::Presenters
  class Preset < Base
    def action_identifier
      "preset_#{model.number}"
    end
  end
end
