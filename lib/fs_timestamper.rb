require 'fs_timestamper/version'
require 'fs_timestamper/timestampers/fixed_timestamper'

module FsTimestamper
  # TimeStamper class
  # Facade class that serves as a simple front-facing interface.
  # It doesn't perform additional functionalities than handling requests,
  # delegating responsabilities and return responses
  # @example
  # ```ruby
  # ts = TimeStamper.new
  # ts.generate_fixed_timestamps('/home', Time.now, false, false)
  # ts.apply_timestamp_changes
  # @author creyes-dev
  class TimeStamper
    # Returns a message including all files and folders contained in the
    # specified filestystem path, each file and folder includes its
    # timestamp assigned using the specified datetime
    # @param path [String] filesystem directory root
    # @param time [Time] datetime to be assigned
    # @param date_only [TrueClass] only assign the date part of time
    # @param creation_only [TrueClass] only assign the creation timestamp
    # @return response [Array] array of EntryTimestampMessage objects
    def generate_fixed_timestamps(path, time, date_only, creation_only)
      @timestamper = TimeStampers::FixedTimeStamper.new
      @timestamper.generate_timestamps(path, time, date_only, creation_only)
    end

    # Handles the assigned timestamp recording request,
    # it returns message containing every recorded timestamp in each
    # filesystem entry
    # @return response [Array of EntryTimestampMessage] response
    # destined to clients
    def apply_timestamp_changes
      @timestamper.apply_timestamp_changes
    end
  end
end
