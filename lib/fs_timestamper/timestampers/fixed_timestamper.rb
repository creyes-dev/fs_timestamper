require 'fs_timestamper/timestampers/abstract_timestamper'
require 'fs_timestamper/entrytimestampers/fixed_entry_timestamper'
require 'fs_timestamper/iterators/preorder_entries_iterator'
require 'date'

module FsTimestamper
  module TimeStampers
    # FixedTimeStamper Class
    # Concrete TimeStamper Class used to assign and record filesystem
    # timestamps using the specified datetime
    # @example
    # ```ruby
    # ts = FixedTimeStamper.new
    # ts.generate_timestamps('/home', Time.now, false, false)
    # ts.apply_timestamp_changes
    # @author creyes-dev
    class FixedTimeStamper < AbstractTimeStamper
      attr_accessor :datetime

      def initialize
        super()
      end

      # Assigns fixed timestamps to the filesystem entries
      # @param path [String] filesystem directory root
      # @param datetime [Time] datetime that will be assigned to the filesystem entries timestamps
      # @param date_only [TrueClass] only assign the date part of time
      # @param creation_only [TrueClass] only assign the creation timestamp
      # @return response [Array of EntryTimestampMessage] response destined to clients
      def generate_timestamps(path, datetime, date_only, creation_only)
        @datetime = datetime
        assign_timestamps(path, date_only, creation_only)
      end

      protected

      # Implements the set_iterator abstract method to instantiate 
      # the iterator this class needs to assign timestamps 
      def set_iterator
        @iterator = Iterators::PreOrderEntriesIterator.new(@root_entry)
      end

      # Implements the set_iterator abstract method to instantiate 
      # the iterator this class needs to assign timestamps
      def build_entry_timestamper
        @entry_timestamper = EntryTimeStampers::FixedEntryTimeStamper.new(@datetime)
      end
    end
  end
end