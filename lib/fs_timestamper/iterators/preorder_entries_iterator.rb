module FsTimestamper
  module TimeStampers
    # PreOrderEntriesIterator Class
    # Iterator class that provide a way to access the filesystem entries
    # that are nodes and leafs of the tree which specified root
    # is the EntryComposite object provided
    # @example
    # ```ruby
    # it = PreOrderEntriesIterator.new(root)
    # it.has_next?
    # next = it.next_item
    # item = it.item(5)
    # @author creyes-dev
    class PreOrderEntriesIterator
      # Instanciates a PreOrderEntriesIterator object
      # @param entry [EntryComposite] root of the filesystem entries tree
      def initialize(entry)
        @root = entry
        @index = 0
      end

      # Indicates if there is a following item in the
      # EntryComposite tree, if there isn't one then the
      # iterator accessed every item in the tree already
      # @return has_next [TrueClass] indicates if there is a next entry to access
      def has_next?
        if @index == 0 then
          has_next = !@root.nil?
        else
          has_next = !@item.right_entry.nil?
        end
        has_next
      end

      # Returns an EntryComposite object within the tree that has an id
      # equal to the given index
      # @param index [Fixnum] index of the EntryComposite object to return
      # @return found_idex [EntryComposite] item found
      def item(index)
        # n-ary tree search
        discovered_item = @root

        loop do
          if discovered_item.id == index then
            found_item = discovered_item
            break
          end
          break if discovered_item.right_entry.nil?

          discovered_item = discovered_item.right_entry
        end
        found_item
      end

      # Return the next filesystem entry in the tree following a preorder
      # method to access each element, if the item class variable is zero then
      # the next item is the root
      # @return item [EntryComposite] next item
      def next_item
        @item = @index == 0? @root : @item.right_entry
        @index = @item.id
        @item
      end
    end
  end
end