require 'spec_helper'

describe DriveConnect::Serializers::DriveSetup do
  let(:drive) { build(:drive) }
  let(:serializer) { DriveConnect::Serializers::DriveSetup.new(drive) }
  let(:json) { serializer.to_json }

  it 'has the drive ip address' do
    expect(json[:IP]).to eq drive.ip_address
  end

  it 'has the name' do
    expect(json[:Name]).to eq drive.name
  end

  it 'has the port' do
    expect(json[:Port]).to eq drive.port.to_s
  end

  it 'has the remote id' do
    expect(json[:Id]).to eq drive.remote_identifier
  end

  it 'has the frequency' do
    expect(json[:Freq]).to eq drive.update_frequency
  end

  it 'has the command' do
    expect(json[:Command]).to eq 'danfoss'
  end
end
