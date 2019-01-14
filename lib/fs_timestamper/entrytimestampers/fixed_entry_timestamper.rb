require_relative 'entry_timestamper'

module FsTimestamper
  module EntryTimeStampers
    # FixedEntryTimeStamper class
    # Concrete class that assign a fixed timestamp to filesystem entries
    # @example
    # ```ruby
    # es = FixedEntryTimeStamper.new(Time.now)
    # es.modify_timestamp(entry)
    # @author creyes-dev
    class FixedEntryTimeStamper < EntryTimeStamper
      def initialize(datetime)
        @datetime = datetime
      end

      protected

      def modify_creation_timestamp(entry)
        entry.new_created_datetime = @datetime
      end

      def modify_modification_timestamp(entry)
        entry.new_modified_datetime = @datetime
      end
    end
  end
end