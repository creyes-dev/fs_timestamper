module FsTimestamper
  module FileSystem
    class FileEntry < EntryComposite
      def initialize(id, path, left)
        super(id, path, left)
      end
    end
  end
end