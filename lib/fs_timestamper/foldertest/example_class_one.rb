require_relative 'example_class_two'

module FsTimestamper
  module FolderTest
    class ExampleClassOne
      def example
        obj_two = ExampleClassTwo.new
        "class example one " + obj_two.example
      end
    end
  end
end
