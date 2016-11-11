require_relative '../modules/evented'
require_relative 'sync'

module DriveConnect::Store
  class SyncRunner

    include DriveConnect::Modules::Evented

    KLASSES = %w(Director Drive Action Preset)

    def initialize
      @sync_instances = KLASSES.map do |klass_suffix|
        klass = "DriveConnect::Models::#{klass_suffix}".constantize
        Sync.new(klass).tap do |instance|
          instance.on :done, method(:job_done)
        end
      end
    end

    def run!
      @done_count = 0
      @sync_instances.each(&:sync!)
    end

    def job_complete?
      @done_count == @sync_instances.length
    end

    def complete!
      trigger(:done)
    end

    def job_done
      @done_count += 1
      complete! if job_complete?
    end

    def unbind_all!
      @sync_instances.each do |instance|
        instance.off :done, method(:job_done)
      end
    end
  end
end
