require 'fs_timestamper/version'
require 'fs_timestamper/otherfoldertest/example_class_accessor'

module FsTimestamper
  class Error < StandardError; end
  # Your code goes here...
  class HelloTest
    def hello_world
      "hello world"
    end
    def get_text
      folder_test = OtherFolderTest::ExampleClassAccessor.new
      folder_test.get
    end
  end
end
