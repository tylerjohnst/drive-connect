require 'spec_helper'

describe DriveConnect::Connectors::Director do
  let(:director)  { build(:director) }
  let(:connector) { DriveConnect::Connectors::Director.new(FakeHTTPAdapter, director) }

  it 'it knows which resource to POST to to provision a new director' do
    expect(connector.connection_options[:path]).to eq '/director'
  end

  it 'can generate a json payload' do
    expect(connector.connection_options[:body].length).to be > 0
  end

  it 'generates a proper host' do
    expect(connector.connection_options[:host]).to eq director.host
  end

  it 'has the token of the drive' do
    expect(connector.connection_options[:token]).to eq director.token
  end

  it 'the drive is not provisioned it uses the preshared default token' do
    expect(connector.connection_options[:token]).to eq DriveConnect::Connectors::Director::DEFAULT_TOKEN
  end

  it 'can deliver the payload' do
    connector.work! do |result|
      expect(result).to be_a Hash
    end
  end
end
