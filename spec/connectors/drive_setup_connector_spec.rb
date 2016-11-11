require 'spec_helper'

describe DriveConnect::Connectors::DriveSetup do
  let(:director)  { build(:director) }
  let(:drive)     { build(:drive) }
  let(:connector) { DriveConnect::Connectors::DriveSetup.new(FakeHTTPAdapter, drive, director) }
  let(:connection_options) { connector.connection_options }

  it 'uses the create end point if the drive is not persisted' do
    drive.is_provisioned = false
    expect(connection_options[:path]).to eq '/drives'
  end

  it 'uses the remote id in the path if the drive is persisted' do
    drive.is_provisioned = true
    drive.remote_identifier = 'ABC'
    expect(connection_options[:path]).to eq '/drives/ABC/config'
  end

  it 'appends the correct token' do
    director.token = 'foobar'
    expect(connection_options[:token]).to eq director.token
  end

  it 'appends the correct host' do
    expect(connection_options[:host]).to eq director.host
  end

  it 'generates the JSON body' do
    expect(connection_options[:body][:Command]).to_not be_nil
  end

  it 'sends a POST request when provisioning for the first time' do
    drive.is_provisioned = false
    expect(FakeHTTPAdapter).to receive(:post!)
    connector.work!
  end

  it 'sends a PUT request when updating the provisioned server' do
    expect(FakeHTTPAdapter).to receive(:put!)
    drive.is_provisioned = true
    drive.remote_identifier = 'ABC'
    connector.work!
  end
end
