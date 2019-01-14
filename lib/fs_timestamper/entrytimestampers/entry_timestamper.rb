module FsTimestamper
  module EntryTimeStampers
    # EntryTimeStamper class
    # Abstract class used as a basis for entry timestampers
    # that must implement the abstract methods defined
    # in this class to assign a timestamp to a single filesystem entry
    # @author creyes-dev
    class EntryTimeStamper
      attr_accessor :date_only, :creation_only

      # Assign creation and modification timestamp to the given filesystem entry
      # @param entry [EntryComposite] filesystem entry
      def modify_timestamp(entry)
        # first modify the creation datetime
        modify_creation_timestamp(entry)
        # after modify the modification datetime
        modify_modification_timestamp(entry)
      end

      protected

      # Abstract method subclasses implement to assign the creation datetime
      # to the given filesystem entry
      # @param entry [EntryComposite] filesystem entry
      def modify_creation_timestamp(entry)
        raise 'Called abstract method: modify_creation_timestamp'
      end

      # Abstract method subclasses implement to assign the modification datetime
      # to the given filesystem entry
      # @param entry [EntryComposite] filesystem entry
      def modify_modification_timestamp(entry)
        raise 'Called abstract method: modify_modification_timestamp'
      end
    end
  end
end