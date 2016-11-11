module DriveConnect::Presenters
  class Base

    attr_accessor :model

    def initialize(model)
      @model = model
    end

    def raw_attribute(method_name)
      model.read_attribute(method_name)
    end

    # @param [Symbol] method_name
    def model_attribute(method_name)
      respond_to?(method_name) ? public_send(method_name) : model.public_send(method_name)
    end

    def method_missing(method_name, *args, &block)
      model.respond_to?(method_name) ? model.public_send(method_name, *args, &block) : super
    end
  end
end
