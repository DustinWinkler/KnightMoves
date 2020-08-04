class Node
  attr_accessor :coord, :moves, :parent

  POSSIBLE_MOVES = [[1, -2], [2, -1], [2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2]]

  def initialize(coord, parent = nil)
    @coord = coord
    @moves = []
    @parent = parent
  end

  def make_moves
    moves = []
    i = 0
    until i == 7
      change = POSSIBLE_MOVES[i]
      new_move = [[coord[0] + change[0], coord[1] + change[1]]].flatten
      moves << Node.new(new_move, self) if new_move[0].between?(0,7) && new_move[1].between?(0,7)
      i += 1
    end
    @moves = moves
  end

  
end

def find_shortest_path(start_obj, end_coord)
  q = []
  q << start_obj
  loop do 
    current = q.shift
    return current if current.coord[0] == end_coord[0] && current.coord[1] == end_coord[1]
    current.make_moves.each { |child| q << child }
  end
end

def knight_moves(start_coord, end_coord)
  results = []
  graph = Node.new(start_coord)
  path = find_shortest_path(graph, end_coord)
  until path == nil
    results.unshift(path.coord)
    path = path.parent
  end
  puts "You made it in #{results.length - 1} moves \nYour path is: "
  results.each { |coord| puts "#{coord}"}
end
knight_moves([1,2], [5,4])
knight_moves([0,0], [7,7])