require_relative 'base'

module DriveConnect::Presenters
  class DriveStatus < Base

    # Extracted from P. 181 - FC200_1101400kW_DesignGuide_MG20Z102.pdf
    STATUS_WORDS = [
      [ "control_ready",      0x00000001 ],
      [ "drive_ready",        0x00000002 ],
      [ "coasting_stop",      0x00000004 ],
      [ "warnings",           0x00000080 ],
      [ "speed_at_reference", 0x00000100 ],
      [ "operation_mode",     0x00000200 ],
      [ "in_freqency_range",  0x00000400 ],
      [ "running",            0x00000800 ],
      [ "voltage_warning",    0x00002000 ],
      [ "current_limit",      0x00004000 ],
      [ "thermal_warning",    0x00008000 ]
    ]

    def has_payload?
      @model && @model.length > 0 && !@model.has_key?('Error')
    end

    def heatsink_temperature
      temperature = json('drive_status.heatsink_temp')
      "#{temperature}°C"
    end

    def motor_speed
      "#{json 'motor_status.speed'} RPM"
    end

    def motor_voltage
      voltage = json('motor_status.voltage').to_f / 10
      "#{voltage}V"
    end

    def motor_frequency
      "#{json 'motor_status.frequency'}Hz"
    end

    def status
      STATUS_WORDS.select do |(label, hex)|
        status_word & hex > 0
      end.map(&:first)
    end

    def status_word
      json('flags.status_word').to_i
    end

    def energy_savings
      savings = json('payback.energy_savings')
      "#{humanize_number savings} kWh"
    end

    def power_reference
      percentage = json('payback.power_reference_factor')
      "#{percentage}%"
    end

    def investment
      price = json('payback.investment')
      "$#{humanize_number price}"
    end

    def energy_cost
      cost = json('payback.energy_cost').to_i * 0.01
      "$#{humanize_number cost}/kWh"
    end

    %w(running operating).each do |field|
      define_method "#{field}_hours" do
        hours = json("payback.#{field}_hours")
        "#{humanize_number hours} Hours"
      end
    end

    def number_of_starts
      starts = json('payback.number_of_starts')
      "#{starts} Starts"
    end

    private

    # Extracted from ActiveSupport: https://github.com/rails/rails/blob/master/activesupport/lib/active_support/number_helper/number_to_delimited_converter.rb#L6
    DELIMITED_REGEX = /(\d)(?=(\d\d\d)+(?!\d))/

    def humanize_number(number)
      formatted = sprintf("%.2f", number)
      left, right = formatted.split('.')
      left.gsub!(DELIMITED_REGEX) { |number_to_delimit| "#{number_to_delimit}," }
      [left, right].delete_if { |s| s == '00' }.join('.')
    end

    def json(search_chain)
      search_chain.split('.').inject(@model) { |hash, key| hash[key] } rescue ''
    end
  end
end
