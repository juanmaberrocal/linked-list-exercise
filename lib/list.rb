class List
  include Enumerable

  attr_accessor :head, :tail, :sorted

  def initialize(options={})
    @sorted = (options[:sorted] == 1)
    @head = nil
    @tail = nil
  end

  # add object to list based on list type
  def add(object)
    # instantiate new object
    new_node = Node.new(object)

    # check if list is empty
    if empty?
      # if empty, object is head|tail
      @head = new_node
      @tail = @head
    else
      # if not empty, check if has to be sorted
      if @sorted
        # keep track of prev node
        prev_node = nil

        # go through each list element
        each do |curr_node|
          # if element is greater than new object
          if curr_node.object > object
            # check if a prev node has been set
            if prev_node.nil?
              # if no prev node, new object is head
              @head = new_node
            else
              # if prev node set, update :next
              prev_node.next = new_node
            end

            # set :next of new node
            new_node.next = curr_node
          else
            # if element is smaller than new object
            if curr_node.next.nil?
              # only set new tail if current node is last
              curr_node.next = new_node
              @tail = new_node
            end
          end

          # keep track of prev node
          prev_node = curr_node
        end
      else
        # if no sort, add to end of list
        @tail.next = new_node
        @tail = @tail.next
      end
    end
  end

  protected
  # enumerable mixin method
  def each
    if block_given?
      current_node = @head

      while current_node != nil
        yield current_node
        current_node = current_node.next
      end
    end
  end

  public
  # returns all elements in list
  def elements
    # set array of objects and add each
    objects = []
    each{ |node| objects << node.object }

    # return array of element objects
    objects
  end

  protected
  # returns true if the list is empty, false otherwise
  def empty?
    # if head and tail are nil, no node has been added
    @head.nil? and @tail.nil?
  end

  public
  # returns length of list
  def length
    # leverage #elements method which returns array of objects in list
    elements.length
  end

  # returns true if object is a member of the list, false otherwise
  def member?(object)
    # check every object in list
    each do |node|
      # if objects match, break loop and return true
      if node.object == object
        return true
      end
    end

    # return false if all elements checked with no matches
    return false
  end

  # returns and removes the first element of the list; or nil if the list is empty
  def pop
    if empty?
      nil
    else
      # set objected "popped" and new head
      popped_object = @head.object
      @head = @head.next

      # return object
      popped_object
    end
  end

end