require 'spec_helper'

describe DriveConnect::Presenters::Action do

  it 'formats the on_time time correctly' do
    model = build(:action)
    model.update_attributes(on_time: hours(5) + minutes(11))
    presenter = DriveConnect::Presenters::Action.new(model)
    expect(presenter.model_attribute(:on_time)).to eq '05:11'
  end

  it 'formats the off_time correctly' do
    model = build(:action)
    model.update_attributes(off_time: hours(9) + minutes(32))
    presenter = DriveConnect::Presenters::Action.new(model)
    expect(presenter.model_attribute :off_time).to eq '09:32'
  end

  it 'Prefixes the number with a letter' do
    model = build(:action)
    model.update_attributes(number: 1)
    presenter = DriveConnect::Presenters::Action.new(model)
    expect(presenter.model_attribute :display_number).to eq 'A1'
  end

  it 'knows if its disabled' do
    model = build(:action, 'on_action' => '0', 'off_action' => '0')
    presenter = DriveConnect::Presenters::Action.new(model)
    expect(presenter.is_disabled?).to eq true
  end
end

def minutes(n)
  n * 60
end

def hours(n)
  minutes(n) * 60
end
