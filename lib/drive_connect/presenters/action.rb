require_relative 'base'

module DriveConnect::Presenters
  class Action < Base

    [:on, :off].each do |type|
      define_method "#{type}_time" do
        hour = public_send("#{type}_time_hour").rjust(2, '0')
        minute = public_send("#{type}_time_minute").rjust(2, '0')
        "#{hour}:#{minute}"
      end

      define_method "#{type}_time_integer" do
        model.public_send(:raw_attribute, "#{type}_time")
      end

      define_method "#{type}_time_hour" do
        (model.public_send("#{type}_time").to_i / 60 / 60).to_s
      end

      define_method "#{type}_time_minute" do
        (model.public_send("#{type}_time").to_i / 60 % 60).to_s
      end

      define_method "#{type}_action_code" do
        model.attributes["#{type}_action"]
      end
    end

    def occurrence_code
      model.attributes["occurrence"].to_s
    end

    def display_number
      "A#{model.number}"
    end

    def is_disabled?
      model_attribute(:on_action).to_i == 0
    end
  end
end
