require 'spec_helper'

describe DriveConnect::Connectors::DriveConfiguration do
  let(:director) { build(:director) }
  let(:drive) { build(:drive) }
  let(:preset) { build(:preset) }
  let(:connector) { DriveConnect::Connectors::DriveConfiguration.new(FakeHTTPAdapter, drive, director) }
  let(:connection_options) { connector.connection_options }

  before(:each) do
    allow(drive).to receive(:presets).and_return [preset]
  end

  it 'it uses the right path to set the config' do
    drive.is_provisioned = true
    drive.remote_identifier = 'ABC'
    expect(connection_options[:path]).to eq '/drives/ABC'
  end

  it 'sends a post request' do
    expect(FakeHTTPAdapter).to receive(:put!)
    connector.work!
  end
end
