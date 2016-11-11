require 'spec_helper'

describe DriveConnect::Serializers::Director do

  let(:drive)      { build(:drive, remote_identifier: '0F00') }
  let(:director)   { build(:director) }
  let(:serializer) { DriveConnect::Serializers::Director.new(director) }
  let(:json)       { serializer.to_json }

  it 'has the listen port' do
    expect(json[:Listen]).to eq ':80'
  end

  it 'has the auth token' do
    expect(json[:AuthToken]).to eq director.token
  end
end

