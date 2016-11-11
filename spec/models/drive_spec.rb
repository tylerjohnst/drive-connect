require 'spec_helper'

describe DriveConnect::Models::Drive do
  it 'returns the index of the loop type' do
    drive = DriveConnect::Models::Drive.new('loop_type' => 0)
    expect(drive.loop_type).to eq DriveConnect::DRIVE_LOOP_TYPES[0]
  end
end
