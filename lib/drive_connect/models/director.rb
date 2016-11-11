require_relative 'base'
require_relative '../modules/dirty'

module DriveConnect::Models
  class Director < Base

    include DriveConnect::Modules::Dirty

    field :id, type: Integer
    field :user_id, type: Integer
    field :name
    field :token
    field :location
    field :host
    field :serial_number
    field :port, type: Integer
    field :is_deploying, type: Boolean
    field :is_synchronized, type: Boolean
    field :last_synchronized_at, type: Time
    field :is_provisioned, type: Boolean
    field :provisioned_at, type: Time
    field :created_at, type: Time
    field :updated_at, type: Time

    def self.all!
      CollectionProxy.new(self, klass: self)
    end

    def drives
      @drives ||= CollectionProxy.new(Drive, where: ['director_id', '=', self.id])
    end
  end
end
