require_relative 'base'

module DriveConnect::Presenters
  class Drive < Base

    def actions
      @actions ||= as_presenter(Action, model.actions)
    end

    def presets
      @presets ||= as_presenter(Preset, model.presets)
    end

    def open_loop_type?
      model_attribute(:loop_type) == DriveConnect::DRIVE_LOOP_TYPES[0]
    end

    def closed_loop_type?
      closed_pressure_loop_type? || closed_flow_loop_type?
    end

    def closed_pressure_loop_type?
      model_attribute(:loop_type) == DriveConnect::DRIVE_LOOP_TYPES[1]
    end

    def closed_flow_loop_type?
      model_attribute(:loop_type) == DriveConnect::DRIVE_LOOP_TYPES[2]
    end

    def director
      @director ||= model.director
    end

    private

    def as_presenter(klass, models)
      models.map { |instance| klass.new(instance) }
    end
  end
end
