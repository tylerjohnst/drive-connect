module DriveConnect::Serializers
  class Base
    def initialize(model)
      @model = model
    end

    def fetch_attributes_from_object(keys, presenter)
      keys.each_with_object(Hash.new) do |key, hash|
        hash[key] = presenter.model_attribute(key)
      end
    end
  end
end
