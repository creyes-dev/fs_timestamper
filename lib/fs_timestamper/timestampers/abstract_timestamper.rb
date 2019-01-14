require 'fs_timestamper/filesystem/file_system_manager'
require 'fs_timestamper/filesystem/entry_composite'
require 'fs_timestamper/filesystem/folder'
require 'fs_timestamper/filesystem/file_entry'
require 'fs_timestamper/iterators/preorder_entries_iterator'
require 'fs_timestamper/entrytimestampers/fixed_entry_timestamper'
require 'fs_timestamper/messages/entry_timestamp_message'
require 'date'

module FsTimestamper
  module TimeStampers
    # AbstractTimeStamper Class
    # Abstract class used as a basis for every timeastamper class that
    # introduces a different assigning timestamps methods to filesystem entries
    # it provides the assigning timesatamp algorithm and map the objects to
    # return messages destined to clients
    # @author creyes-dev
    class AbstractTimeStamper
      def initialize
        @fs_manager = FileSystem::FileSystemManager.new
      end

      # Template method that assigns timestamps to the filesystem entries
      # contained in the specified filesystem path and returns a
      # response message containing all the filesystem entries each with
      # its own assigned timestamp
      # @param path [String] filesystem directory root
      # @param date_only [TrueClass] only assign the date part of time
      # @param creation_only [TrueClass] only assign the creation timestamp
      # @return response [Array of EntryTimestampMessage] response destined to clients
      def assign_timestamps(path, date_only, creation_only)
        get_entries(path)
        set_iterator
        set_entry_timestamper(date_only, creation_only)
        response = assign_entries_timestamps
      end

      # Handles the assigned timestamp recording request,
      # it returns a collection of messages, each one contains the
      # recorded timestamp in a filesystem entry
      # @return response [Array of EntryTimestampMessage] response destined to clients
      def apply_timestamp_changes
        @fs_manager.save_timestamp_changes(@root_entry)
      end

      protected

      # Abstract method subclasses use to instanciate their corresponding
      # iterator subclass in the @iterator class variable
      def set_iterator
        raise 'Called abstract method: set_iterator'
      end

      # Abstract method subclasses use to instanciate their corresponding
      # entry timestamper subclass in the @entry_timestamper class variable
      def build_entry_timestamper
        raise 'Called abstract method: build_entry_timestamper'
      end

      private

      # Get the filesystem entry that corresponds with the specified filesystem path,
      # and includes its filesystem entries subtree, that EntryComposite object is set
      # in the @root_entry class variable
      # @param path [String] filesystem directory root
      def get_entries(path)
        @path = path
        @root_entry = @fs_manager.get_entries(path)
      end

      # Sets and configurate the entry timestamper that subclass uses to
      # assign timestamps
      # @param date_only [TrueClass] only assign the date part of time
      # @param creation_only [TrueClass] only assign the creation timestamp
      def set_entry_timestamper(date_only, creation_only)
        build_entry_timestamper
        @entry_timestamper.date_only = date_only
        @entry_timestamper.creation_only = creation_only
      end

      # Assign timestamps to the retreived filesystem subtree and returns
      # a collection of messages, each one contains the
      # assigned timestamp in a filesystem entry
      # @return response [Array of EntryTimestampMessage] response destined to clients
      # that contains the reuslt of timestamps assignments
      def assign_entries_timestamps
        raise 'Iterator not initalized' if @iterator.nil?
        raise 'Entry timestamper not initialized' if @entry_timestamper.nil?

        entries_messages = []
        while @iterator.has_next?
          next_entry = @iterator.next_item

          @entry_timestamper.modify_timestamp(next_entry)

          entry_message = Messages::EntryTimestampMessage.new(next_entry.id, next_entry.path,
                                                              next_entry.original_created_datetime,
                                                              next_entry.original_modified_datetime,
                                                              next_entry.new_created_datetime,
                                                              next_entry.new_modified_datetime)

          entries_messages << entry_message
        end
        entries_messages
      end
    end
  end
end
