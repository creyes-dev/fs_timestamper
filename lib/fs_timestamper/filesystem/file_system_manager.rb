require_relative 'entry_composite'
require_relative 'folder'
require_relative 'file_entry'
require 'fs_timestamper/iterators/preorder_entries_iterator'
require 'fileutils'

module FsTimestamper
  module FileSystem
    # FileSystemManager class
    # Interact with local filesystem to create trees of EntryComposite objects
    # and record filesystem entries timestamps
    # @example
    # ```ruby
    # fs = FileSystemManager.new
    # fs.get_entries('/home')
    # fs.save_timestamp_changes(root)
    # @author creyes-dev
    class FileSystemManager
      # Returns a EntryComposite object that represent the
      # provided filesystem path root that includes the files and
      # folders included in the filesystem subtree
      # @param path [String] filesystem path to a file or a folder
      # @return [EntryComposite] represent the provded filesystem path root
      def get_entries(path)
        if entry_exists?(path) then
          @index = 1
          root = build_entry(:folder, @index, path)
          # Append all the nodes and leafs of the tree
          append_node(root)
        else
          raise "Path doesn't exist" # TODO: this should go in the build_entry method
        end
        root
      end

      # Record the assigned timestamps from each EntryComposite contained in
      # the provided EntryComposite tree
      # @param root [EntryComposite] root of the EntryComposite tree that contains
      # the timestamps to be recorded in the filesystem
      def save_timestamp_changes(root)
        iterator = Iterators::PreOrderEntriesIterator.new(root)
        while iterator.has_next?
          next_entry = iterator.next_item
          record_creation_timestamp(next_entry.path, next_entry.new_created_datetime)
          record_modification_timestamp(next_entry.path, next_entry.new_modified_datetime)
        end
      end

      private

      # Build a EntryComposite using the provided data and set the EntryComposite
      # creation and modification timestamps retrieved from the filesystem
      # @param type [Symbol] identifies if the entry is a folder or a file
      # @param root [Fixnum] provided id of the entry
      # @param path [String] filesystem entry path
      # @param left_entry [EntryComposite] previous Entry following the
      # preorder tree ordering method
      # @return entry [EntryComposite] builded EntryComposite
      def build_entry(type, index, path, left_entry = nil)
        if type == :folder then
          entry = FileSystem::Folder.new(index, path, left_entry)
        else
          entry = FileSystem::FileEntry.new(index, path, left_entry)
        end

        entry.original_created_datetime = get_creation_timestamp(path)
        entry.original_modified_datetime = get_modification_timestamp(path)
        entry
      end

      # Determine if the provided path corresponds with a valid filesystem path
      # @param entry [String] filesystem path
      # @return exists [TrueClass] provided path is valid 
      def entry_exists?(entry)
        File.exist?(entry)
      end

      # Returns the creation timestamp of the provided filesystem entry
      # @param path [String] filesystem entry path
      # @return timestamp [Time] provided filesystem entry creation timestamp
      def get_creation_timestamp(path)
        nil
      end

      # Returns the modification timestamp of the provided filesystem entry
      # @param path [String] filesystem entry path
      # @return timestamp [Time] provided filesystem entry modification timestamp
      def get_modification_timestamp(path)
        File.mtime(path)
      end

      # Recursive method that adds entries to the EntryComposite tree 
      # using the Pre-order (NLR) tree traversal algorithm, it's neccesary to 
      # append the node containing leafs (files) first and after that the 
      # containing nodes (folders), the last ones recursively call this method
      # to append its own entries
      # @param node [EntryComposite] node to add to the parent
      # @param parent [EntryComposite] parent node
      def append_node(node, parent = nil)
        # Add the node to the parents node list
        add_entry(node, parent)

        # Recursively get all filesystem entries contained in the current folder
        if node.is_a? FileSystem::Folder then
          pattern = '/*'
          entries = Dir.glob(node.path + pattern).sort_by { |a| a.downcase }
          files = []
          folders = []

          # Store files and folders in different collections
          # because files will be added before folders
          entries.each do |e|
            if File.directory? e
              folders << e
            else
              files << e
            end
          end

          # First add contained files
          files.each do |f|
            file = build_entry(:file, @index, f, @left_entry)
            append_node(file, node)
          end

          # After add contained folders and its entries
          folders.each do |f|
            folder = build_entry(:folder, @index, f, @left_entry)
            append_node(folder, node)
          end
        end
      end

      # Recursive method that adds entries to the EntryComposite tree 
      # using the Pre-order (NLR) tree traversal algorithm, it's neccesary to 
      # append the node containing leafs (files) first and after that the 
      # containing nodes (folders), the last ones recursively call this method
      # to append its own entries
      # @param node [EntryComposite] node to add to the parent
      # @param parent [EntryComposite] parent node
      def add_entry(entry, parent)
        @left_entry = entry
        @index += 1
        # If its not root add entry to the parent
        if !parent.nil? then 
          parent.add_entry entry
        end
      end

      # Store the creation timestamp of the provided filesystem entry
      # @param path [String] filesystem entry path
      # @param timestamp [Time] new filesystem entry creation timestamp
      def record_creation_timestamp(path, timestamp)
        # Hook method: Linux filesystems doesn't store creation datetime
      end

      # Store the modification timestamp of the provided filesystem entry
      # @param path [String] filesystem entry path
      # @param timestamp [Time] new filesystem entry modification timestamp
      def record_modification_timestamp(path, timestamp)
        File.utime(timestamp, timestamp, path)
        record_access_timestamp(path, timestamp)
        record_changed_timestamp(path, timestamp)
      end

      # Store the last access timestamp of the provided filesystem entry
      # @param path [String] filesystem entry path
      # @param timestamp [Time] new filesystem entry last access timestamp
      def record_access_timestamp(path, timestamp)
        # Hook method: Already stored with File.utime
      end

      def record_changed_timestamp(path, timestamp)
        # this may require to change the system datetime
      end
    end
  end
end