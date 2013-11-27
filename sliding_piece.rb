require_relative 'piece.rb'

class SlidingPiece < Piece
  attr_accessor :directions

  def initialize(position)
    super(position)
    @directions = []
  end

  def define_moveset
    x = self.position[1]
    y = self.position[0]

    for i in 1..7
      if self.directions.include?(:vertical_horizontal)
        self.moveset << [y + i, x]
        self.moveset << [y - i, x]
        self.moveset << [y, x + i]
        self.moveset << [y, x - i]
      end
      if self.directions.include?(:diagonal)
        self.moveset << [y + i, x + i]
        self.moveset << [y - i, x - i]
        self.moveset << [y - i, x + i]
        self.moveset << [y + i, x - i]
      end
    end
    whittle
  end

end

class Queen < SlidingPiece

  def initialize(position)
    super(position)
    @directions = [:diagonal, :vertical_horizontal]
    define_moveset
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
    define_moveset
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
    define_moveset
  end

  def to_s
    return "\u2656".encode('utf-8') if @color == :white
    "\u265C".encode('utf-8')
  end
end