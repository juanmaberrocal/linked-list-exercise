class List
  include Enumerable

  # set/get sorted flag
  attr_accessor :sorted

  # no need for setter as nodes behaves as an array
  attr_reader :nodes

  def initialize(options={})
    # set sorted as boolean flag
    @sorted = (options[:sorted] == 1)

    # set "relation" to node
    @nodes = []
  end

  # add object to list based on list type
  def add(object)
    @nodes << Node.new(object)
    
    # sort list objets
    if self.sorted
      @nodes.sort_by!(&:object)
    end

    # EXTRA:
    # add node links
    Node.add_links(@nodes)
  end
  
  # enumerable mixin method
  def each
  end

  # returns all elements in list
  def elements
    self.nodes.map(&:object)
  end

  # returns true if the list is empty, false otherwise
  def empty?
    self.length == 0
  end

  # returns length of list
  def length
    self.nodes.length
  end

  # returns true if object is a member of the list, false otherwise
  def member?(object)
    self.elements.include?(object)
  end

  # returns and removes the first element of the list; or nil if the list is empty
  def pop
    if self.empty?
      nil
    else
      self.nodes.shift.object
    end
  end

end