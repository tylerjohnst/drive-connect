require 'spec_helper'

describe DriveConnect::Presenters::Drive do

  def create_presenter(attributes = {})
    drive = build(:drive)
    allow(drive).to receive(:actions).and_return [build(:action)]
    DriveConnect::Presenters::Drive.new(drive)
  end

  it 'delegates the methods to the drive if its an attribute' do
    presenter = create_presenter
    expect(presenter.model_attribute :name).to eq presenter.model.name
  end

  it 'can fetch and build action presenters' do
    presenter = create_presenter(actions_attributes: {
      0 => {
        on_action: 'foobar',
        on_time: Time.parse('05:00')
      }
    })

    expect(presenter.actions.length).to eq 1
  end
end

