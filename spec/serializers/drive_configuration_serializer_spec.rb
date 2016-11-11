require 'spec_helper'

describe DriveConnect::Serializers::DriveConfiguration do

  let(:on_time) { 39000 }
  let(:off_time) { 48600 }
  let(:on_action) { '3' }
  let(:off_action) { '4' }

  let(:drive) do
    build(:drive).tap do |model|
      allow(model).to receive(:actions).and_return(10.times.map { |i| build(:action, 'number' => i, 'on_time' => on_time, 'on_action' => on_action, 'off_time' => off_time, 'off_action' => off_action, 'occurrence' => 3) })
      allow(model).to receive(:presets).and_return(10.times.map { |i| build(:preset, 'number' => i, 'value' => 10 ) })
    end
  end

  let(:serializer) { DriveConnect::Serializers::DriveConfiguration.new(drive) }
  let(:drive_json) { serializer.to_json }
  let(:timed_actions) { drive_json['timed_actions'] }

  it 'has 0 as the first key' do
    expect(timed_actions).to have_key '0'
  end

  it 'has the motor speed high limit rpm' do
    expect(drive_json['0413_motor_speed_high_limit_rpm']).to eq drive.high_value
  end

  it 'has the low speed limit' do
    expect(drive_json['0411_motor_speed_low_limit_rpm']).to eq drive.low_value
  end

  it 'has the motor voltage' do
    expect(drive_json['0122_motor_voltage']).to eq 240
  end

  it 'has the motor hp' do
    expect(drive_json['0121_motor_power_hp']).to eq 30000
  end

  it 'has the motor frequency' do
    expect(drive_json['0123_motor_frequency']).to eq 200
  end

  it 'includes the timed actions hash' do
    expect(timed_actions).to be_a Hash
  end

  it 'includes all 10 possible timed actions' do
    expect(timed_actions.length).to eq 10
  end

  it 'has the presets' do
    expect(drive_json['preset_references']).to be_a Hash
  end

  it 'has the value of the preset' do
    expect(drive_json['preset_references']['0']['0310_preset_reference']).to eq 1000
  end

  context 'timed actions' do
    let(:action) { timed_actions['1'] }

    it 'should have the first action' do
      expect(action).to_not be_nil
    end

    it 'has on time' do
      expect(action["2300_on_time"]).to eq on_time
    end

    it 'has the on action code' do
      expect(action["2301_on_action"]).to eq on_action
    end

    it 'has the off time hour' do
      expect(action["2302_off_time"]).to eq off_time
    end

    it 'has the off action code' do
      expect(action["2303_off_action"]).to eq off_action
    end

    it 'has the occurrence code' do
      expect(action["2304_occurrence"]).to eq 3
    end
  end
end
