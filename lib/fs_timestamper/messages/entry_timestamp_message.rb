module FsTimestamper
  module Messages
    # EntryTimestampMessage Class
    # Used to output a filesystem entry operation result to clients
    # @author creyes-dev
    class EntryTimestampMessage
      attr_reader :id, :path,
                  :original_created_datetime, :original_modified_datetime,
                  :new_created_datetime, :new_modified_datetime

      def initialize(id, path,
                    original_creation_datetime, original_modification_datetime,
                    new_creation_datetime, new_modification_datetime)
        @id = id
        @path = path
        @original_created_datetime = original_creation_datetime
        @original_modified_datetime = original_modification_datetime
        @new_created_datetime = new_creation_datetime
        @new_modified_datetime = new_modification_datetime
      end
    end
  end
end
