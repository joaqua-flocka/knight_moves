class Node
  attr_accessor :coordinates, :children, :parent
  def initialize(coordinates, children = [], parent = nil)
    @coordinates = coordinates
    @children = children
    @parent = parent
  end
end

class Graph
  def initialize(root)
    @root = root
  end

  def shortest_path(coordinates)
    tmp = @root
    queue = [@root]
    until queue.empty? || tmp.coordinates == coordinates
      tmp = queue.shift
      x = tmp.coordinates[0]
      y = tmp.coordinates[1]
      children = [
        [x + 1, y+2],
        [x + 1, y-2],
        [x+2, y+1],
        [x+2, y-1],
        [x - 1, y + 2],
        [x-1, y-2],
        [x-2, y+1],
        [x - 2, y - 1]
      ]

      children.each do |child|
        if child[0].between?(0,7) && child[1].between?(0,7)
          tmp.children.push Node.new(child,[],tmp)
        end
      end
      tmp.children.each { |i| queue.push i }
    end
    arr = []
    until tmp == nil
      arr.push tmp.coordinates
      tmp = tmp.parent
    end
    return arr.reverse
  end
end

def knight_moves(start, finish)
  root = Node.new(start)
  graph = Graph.new(root)
  arr = graph.shortest_path(finish)
  puts "Shortest path from #{start} to #{finish}:"
  p arr
end

knight_moves([0,0], [7, 7])