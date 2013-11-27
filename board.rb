require_relative 'tile.rb'
require 'debugger'

class Board
  ALPHA = ("a".."h").to_a
  DEFAULT_BOARD = { :a8 => :rook, :b8 => :knight, :c8 => :bishop, :d8 => :queen,
                    :e8 => :king, :f8 => :bishop, :g8 => :knight, :h8 => :rook,
                    :a1 => :rook, :b1 => :knight, :c1 => :bishop, :d1 => :queen,
                    :e1 => :king, :f1 => :bishop, :g1 => :knight, :h1 => :rook
                  }
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8) { } }
    create_tiles
    #default_populate
  end

  def create_tiles
    @grid.each_index do |row|
      @grid.each_index do |column_space|
        @grid[row][column_space] = Tile.new([row, column_space])
      end
    end
  end

  def display
    #debugger
    puts "  a b c d e f g h\n"
    @grid.each_with_index do |row, index|
      print "#{8 - index} "
      row.each do |tile|
        print tile.to_s
      end
      print "\n"
    end
    return nil
  end

  def default_populate
    @grid[1].map { |tile| tile.set_piece(:pawn)}
    @grid[6].map { |tile| tile.set_piece(:pawn)}

    @grid.flatten.each_with_index do |tile, index|
      tile.set_piece(DEFAULT_BOARD[tile.name]) unless tile.is_occupied?
      tile.piece.set_color(:black) if index < 16 && tile.is_occupied?
      tile.piece.set_color(:white) if index > 47 && tile.is_occupied?
    end
  end

  def move(start, stop)
    start_coord = string_to_xy(start)
    stop_coord = string_to_xy(stop)
    #if no piece at start coordinate, return exception
    #check moveset of the piece at start position
    start_tile = @grid[start_coord[1]][start_coord[0]]
    stop_tile = @grid[stop_coord[1]][stop_coord[0]]
    raise "You don't have a piece at that starting point" unless start_tile.is_occupied?


    if in_moveset?(start_tile.piece.moveset, stop_coord)
      unless is_blocked?(start_tile, stop_tile)
        #take piece out of start_tile, place piece into stop_tile
      end
    end

    #define_moveset

    #out of that array, check if move is in moveset
    #check if move will violate rules such as: blocked, check, capture
    #make move (update tile, piece, grid)
  end

  def in_moveset?(moveset, stop)
    moveset.include?(stop)
  end

  def is_blocked?(start_tile, stop_tile)
    start_coord = start_tile.position
    start_y = start_coord[0]
    start_x = start_coord[1]

    stop_coord = stop_tile.position
    stop_y = stop_coord[0]
    stop_x = stop_coord[1]

    if start_tile.piece == :knight
      true if stop_tile.is_occupied? && stop_tile.piece.color == start_tile.piece.color
    else
      if start_y == stop_y && start_x != stop_x #horizonal
        (start_x + 1..stop_x).each do |between_x|
          return false if @grid[start_y][between_x].is_occupied?
        end
        return true
      elsif start_y != stop_y && start_x == stop_x #vertical
        (start_y + 1..stop_y).each do |between_y|
          return false if @grid[between_y][start_x].is_occupied?
        end
        return true
      else #diagonal
        (start_y + 1..stop_y).each do |between_y|
          (start_x + 1..stop_x).each do |between_x|
            return false if @grid[between_y][between_x].is_occupied?
          end
        end
        return true
      end
    end

  end

  def string_to_xy(string)
    x = ALPHA.index(string[0])
    y = Integer(8 - string[1])    #user sees y-axis reflected, top is 8
    [y,x]
  end

end

b = Board.new
b.display
b.grid[4][4].set_piece(:queen)
#b.grid[2][4].set_piece(:pawn)
b.display
p b.grid[4][4].piece.find_path([0,4])
#p b.grid[1][4].piece.moveset.length

