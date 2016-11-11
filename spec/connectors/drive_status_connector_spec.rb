require 'spec_helper'

describe DriveConnect::Connectors::DriveStatus do
  let(:director) { build(:director) }
  let(:drive)    { build(:drive) }
  let(:connector){ DriveConnect::Connectors::DriveStatus.new(FakeHTTPAdapter, drive, director) }

  it 'generates the correct path' do
    drive.remote_identifier = 'ABCD'
    expect(connector.connection_options[:path]).to eq '/drives/ABCD/live'
  end

  it 'fetches using a GET request' do
    expect(FakeHTTPAdapter).to receive(:get!).once
    connector.work!
  end
end
