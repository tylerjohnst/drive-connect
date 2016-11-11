module DriveConnect
  DRIVE_LOOP_TYPES = ['Open', 'Closed - Pressure', 'Closed - Flow']

  DRIVE_VOLTAGES = [240, 480, 600, 200, 230, 577, 460]

  DRIVE_SYSTEM_MODES = ['Pool', 'Spa']

  DRIVE_MOTOR_REFERENCES = ['RPM', 'Frequency', 'Percentage']

  DRIVE_FREQUENCIES = [60, 50]

  DRIVE_RPMS = [0, 600, 900, 1200, 1800, 3450, 3600]

  DRIVE_AMA = ['No AMA', 'Cold', 'Hot']

  DRIVE_CLOSED_FEEDBACK_SOURCE = {
    0  => 'Disabled',
    12 => 'AI53',
    13 => 'AI54',
    18 => 'Pulse Input F192',
    19 => 'Pulse Input F133'
  }

  DRIVE_WATER_BODY_UNITS = ['Gallons', 'Liters']

  ACTION_OPTIONS = [
    "Disabled",
    "No action",
    "Select Setup 1",
    "Select Setup 2",
    "Select Setup 3",
    "Select Setup 4",
    nil,
    nil,
    nil,
    nil,
    "Select Preset 0",
    "Select Preset 1",
    "Select Preset 2",
    "Select Preset 3",
    "Select Preset 4",
    "Select Preset 5",
    "Select Preset 6",
    "Select Preset 7",
    "Select Ramp 1",
    "Select Ramp 2",
    nil,
    nil,
    "Run",
    "Run Reverse",
    "Stop",
    nil,
    "DC Brake",
    "Coast",
    "Freeze Output",
    "Start Timer 0",
    "Start Timer 1",
    "Start Timer 2",
    "Set Digital Out A Low",
    "Set Digital Out B Low",
    "Set Digital Out C Low",
    "Set Digital Out D Low",
    "Set Digital Out E Low",
    "Set Digital Out F Low",
    "Set Digital Out A High",
    "Set Digital Out B High",
    "Set Digital Out C High",
    "Set Digital Out D High",
    "Set Digital Out E High",
    "Set Digital Out F High",
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    "Reset Counter A",
    "Reset Counter B",
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    nil,
    "Start Timer 3",
    "Start Timer 4",
    "Start Timer 5",
    "Start Timer 6",
    "Start Timer 7",
    nil,
    nil,
    nil,
    nil,
    nil,
    "Sleep Mode",
    "Derag"
  ]

  ACTION_OCCURANCES = [
    "All days",
    "Working day",
    "Non-working day",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ]

end

class Enum; end;
class Boolean; end;
