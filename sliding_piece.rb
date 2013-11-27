require_relative 'piece.rb'

class SlidingPiece < Piece
  attr_accessor :directions

  def initialize(position)
    super(position)
    @directions = []
  end

  def find_path(stop_coordinate)
    start_x = self.position[1]
    start_y = self.position[0]

    stop_x = stop_coordinate[1]
    stop_y = stop_coordinate[0]

    dx = stop_x - start_x
    dy = stop_y - start_y

    p "dx = #{dx} dy = #{dy}"

    path = []

    if dx.abs == dy.abs
      # Diagonal
      raise "Illegal move " unless self.directions.include?(:diagonal)
      for i in 0..dy
        for j in 0..dx #NOTE TO SELF - REMOVE START
          path << [start_y + i, start_x + j] if i.abs == j.abs
        end
      end
    else
      raise "Illegal move " unless self.directions.include?(:vertical_horizontal)
      if dx == 0 && dy.abs > 1 # Vertical
        for i in 0..dy
          p "start_y = #{start_y} i = #{i}"
          path << [start_y + i, start_x]
        end
      elsif dy == 0 && dx.abs > 1 # Horizontal
        for i in 0..dx
          p "start_x = #{start_x} i = #{i}"

          path << [start_y, start_x + i]
        end
      else # ?????
        puts "You're dumb and you should feel bad."
      end
    end
    return path
  end

end

class Queen < SlidingPiece

  def initialize(position)
    super(position)
    @directions = [:diagonal, :vertical_horizontal]
  end

  def to_s
    return "\u2655".encode('utf-8') if @color == :white
    "\u265B".encode('utf-8')
  end
end

class Bishop < SlidingPiece

  def initialize(position)
    super(position)
    @directions = [:diagonal]
  end

  def to_s
    return "\u2657".encode('utf-8') if @color == :white
    "\u265D".encode('utf-8')
  end
end

class Rook < SlidingPiece

  def initialize(position)
    super(position)
    @directions = [:vertical_horizontal]
  end

  def to_s
    return "\u2656".encode('utf-8') if @color == :white
    "\u265C".encode('utf-8')
  end
end