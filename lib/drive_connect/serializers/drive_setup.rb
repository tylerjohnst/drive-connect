require_relative 'base'

module DriveConnect::Serializers
  class DriveSetup < Base

    def to_json
      presenter = DriveConnect::Presenters::Drive.new(@model)
      {}.tap do |hash|
        hash[:Name] = presenter.model_attribute(:name)
        hash[:IP] = presenter.model_attribute(:ip_address)
        hash[:Port] = presenter.model_attribute(:port).to_s
        hash[:Id] = presenter.model_attribute(:remote_identifier)
        hash[:Freq] = presenter.model_attribute(:update_frequency)
        hash[:Command] = 'danfoss'
      end
    end
  end
end
