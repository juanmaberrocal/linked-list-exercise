class Node

  attr_reader :object
  attr_accessor :next

  def initialize(object)
    @object = object
    @next = nil
  end

  private
  def self.add_links(nodes)
  	nodes.each_with_index do |node, i|
  		node.next = nodes[i+1]
  	end
  end

end