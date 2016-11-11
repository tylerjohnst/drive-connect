require_relative 'base'

module DriveConnect::Serializers
  class DriveConfiguration < Base

    attr_reader :presenter

    TIMED_ACTION_ATTRIBUTES = [
      :on_action_code,
      :occurrence_code,
      :off_action_code
    ]

    def initialize(*args)
      super
      @presenter = DriveConnect::Presenters::Drive.new(@model)
    end

    def to_json
      {
        '0121_motor_power_hp'                  => presenter.raw_attribute(:motor_horsepower).to_i * 100,
        '0122_motor_voltage'                   => presenter.raw_attribute(:motor_voltage).to_i,
        '0123_motor_frequency'                 => presenter.raw_attribute(:motor_frequency).to_i,
        '0124_motor_current'                   => presenter.raw_attribute(:motor_current).to_f,
        '0129_automatic_motor_adaptation_ama'  => presenter.raw_attribute(:automatic_motor_speed).to_i,
        '0341_ramp_1_ramp_up_time'             => presenter.raw_attribute(:ramp_up_time).to_i * 100,
        '0342_ramp_1_ramp_down_time'           => presenter.raw_attribute(:ramp_down_time).to_i * 100,
        '0411_motor_speed_low_limit_rpm'       => presenter.raw_attribute(:low_motor_speed).to_i,
        '0413_motor_speed_high_limit_rpm'      => presenter.raw_attribute(:high_motor_speed).to_i,
        'timed_actions'                        => timed_actions,
        'preset_references'                    => presets
      }
    end

    def timed_actions
      presenter.actions.each_with_object(Hash.new) do |action, hash|
        hash[number_to_index(action)] = {
          "2300_on_time"    => action.model_attribute(:on_time_integer),
          "2301_on_action"  => action.model_attribute(:on_action_code),
          "2302_off_time"   => action.model_attribute(:off_time_integer),
          "2303_off_action" => action.model_attribute(:off_action_code),
          "2304_occurrence" => action.model_attribute(:occurrence_code).to_i
        }
      end
    end

    def presets
      presenter.presets.each_with_object(Hash.new) do |preset, hash|
        hash[preset.raw_attribute(:number).to_s] = {
          "0310_preset_reference" => preset.raw_attribute(:value).to_i * 100
        }
      end
    end

    def number_to_index(model)
      (model.raw_attribute(:number).to_i - 1).to_s
    end
  end
end
