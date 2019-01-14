module FsTimestamper
  module FileSystem
    # Folder class
    # @example
    # ```ruby
    # doc = Document.new('Hamlet', 'Shakespeare', 'To be or...')
    # puts doc.title
    # puts doc.author
    # puts doc.content
    # @author creyes-dev
    class Folder < EntryComposite
      attr_accessor :entries
      # Handles a request
      # @param request [Request] the request object
      # @return [String] the resulting webpage
      def initialize(id, path, left)
        super(id, path, left)
        @entries = []
      end

      def add_entry(entry)
        @entries << entry
      end

    end
  end
end