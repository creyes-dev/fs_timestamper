module FsTimestamper
  module FileSystem
    # EntryComposite class
    # Stores the filesystem path and the actual timestamps of a 
    # filesystem entry. It also stores a unique id, the modified
    # timestamps that can be used to replace the actual filesystem 
    # entry filestamps. If something wrong happens retreiving
    # data from the filesystem or recording data on it, a error 
    # message will be stored in the error_messages array
    # @example
    # ```ruby
    # @author creyes-dev
    class EntryComposite
      attr_accessor :left_entry, :right_entry,
                    :new_created_datetime, :new_modified_datetime,
                    :original_created_datetime, :original_modified_datetime,
                    :error_messages
      attr_reader :id, :path
      # Handles a request
      # @param request [Request] the request object
      # @return [String] the resulting webpage
      def initialize(id, path, left)
        @id = id
        @path = path
        @error_messages = []

        unless left.nil?
          @left_entry = left
          @left_entry.right_entry = self
        end
      end
    end
  end
end