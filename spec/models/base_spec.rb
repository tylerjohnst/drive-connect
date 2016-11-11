require 'spec_helper'

describe DriveConnect::Models::Base do

  context 'serializing' do
    it 'can serialize a date field' do
      model = ModelTestClass.new('created_at' => Time.now.to_s)
      expect(model.created_at).to be_an_instance_of Time
    end

    it 'can serialize an enum field' do
      model = ModelTestClass.new('step' => 1)
      expect(model.step).to eq 'bar'
    end

    it 'returns nil if the value is nil' do
      model = ModelTestClass.new
      expect(model.step).to eq nil
    end

    it 'can deserialize an integer field' do
      model = ModelTestClass.new('number' => '800')
      expect(model.number).to eq 800
    end

    it 'can deserialize booleans' do
      model = ModelTestClass.new('bool' => true)
      expect(model.bool).to eq true
    end

    it 'can deserialize floats' do
      model = ModelTestClass.new('float' => 2.2)
      expect(model.float).to eq 2.2
    end
  end

  it 'can fetch the raw attribute' do
    model = ModelTestClass.new('float' => '123')
    expect(model.raw_attribute(:float)).to eq '123'
  end

  it 'shouldnt throw an exception if the field is missing' do
    model = ModelTestClass.new
    allow(model).to receive(:persist!)
    expect { model.update_attributes(non_field: 'foo') }.not_to raise_error
  end

  it 'can use update_attributes to write multiple values' do
    model = ModelTestClass.new
    allow(model).to receive(:persist!)
    model.update_attributes(step: 'foo', created_at: Time.now)
    expect(model.created_at).to be_a Time
    expect(model.step).to eq 'foo'
  end

  context 'setters' do
    it 'can set an attribute on a model' do
      model = ModelTestClass.new
      model.created_at = Time.now
      expect(model.created_at).to be_a Time
    end

    it 'sets a modified_at timestamp if the attribute changes' do
      model = ModelTestClass.new
      model.float = 15
      expect(model.modified_at).to be_a Time
    end

    it 'does not set modified_at timestamp if the attribute is the same' do
      model = ModelTestClass.new('float' => 15.0)
      model.float = 15.0
      expect(model.modified_at).to be nil
    end
  end

  it 'can determine its own resource name' do
    expect(DriveConnect::Models::Drive.resource_name).to eq 'drives'
  end

  context 'events' do
    let(:model) { ModelTestClass.new }
    it 'can bind events' do
      expect(model).to receive(:id)
      model.on(:sync, model.method(:id))
      model.trigger(:sync)
    end

    it 'can unbind events' do
      expect(model).to_not receive(:parent_id)
      model.on  :sync, model.method(:parent_id)
      model.off :sync, model.method(:parent_id)
      model.trigger(:sync)
    end

    it 'can pass arguments to the method calls' do
      expect(model).to receive(:id).once.with('test')
      model.on :sync, model.method(:id)
      model.trigger(:sync, 'test')
    end
  end
end

class ModelTestClass < DriveConnect::Models::Base
  include DriveConnect::Modules::Dirty

  field :id,         type: Integer
  field :parent_id,  type: Integer
  field :created_at, type: Time
  field :step,       type: Enum,    options: %w(foo bar baz)
  field :number,     type: Integer
  field :bool,       type: Boolean
  field :float,      type: Float
end
