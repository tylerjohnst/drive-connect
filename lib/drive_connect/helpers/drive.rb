module DriveConnect::Helpers
  class Drive
    class << self
      def percentage_between(low, high, percentage)
        low + ((high - low) * (percentage / 100.0))
      end

      def percentage_between_hash(low, high)
        (1..10).each_with_object(Hash.new) do |i, hash|
          percentage = i * 10
          hash[percentage] = percentage_between(low, high, percentage)
        end
      end

      def actions_hash
        {}.tap do |hash|
          DriveConnect::ACTION_OPTIONS.each_with_index do |name, index|
            hash[index.to_s] = name if name
          end
        end
      end

      def water_turnover_options
        6.times.map { |i| [ i + 0.5, i + 1.0 ] }.flatten
      end
    end
  end
end
