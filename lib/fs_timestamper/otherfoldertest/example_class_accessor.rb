require 'fs_timestamper/foldertest/example_class_one'

module FsTimestamper
  module OtherFolderTest
    class ExampleClassAccessor
      def get
        class_one = FolderTest::ExampleClassOne.new
        class_one.example
      end
    end
  end
end
