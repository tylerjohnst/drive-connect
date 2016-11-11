require_relative 'base'

module DriveConnect::Serializers
  class Director < Base

    def to_json
      presenter = DriveConnect::Presenters::Director.new(@model)
      return {
        :Listen => ":#{presenter.model_attribute :port}",
        :AuthToken => presenter.model_attribute(:token)
      }
    end
  end
end
