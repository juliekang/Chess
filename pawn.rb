class Pawn < Piece
  attr_accessor :original_position

  def initialize(position)
    super(position)
    @original_position = true
    define_moveset
  end

  def to_s
    return "\u2659".encode('utf-8') if @color == :white
    "\u265F".encode('utf-8')
  end

  def define_moveset
    x = self.position[1]
    y = self.position[0]

    # remember they can only move forward, dependent on color
    if @color == :white
      if @original_position
        self.moveset << [y - 2, x]
        self.moveset << [y - 1, x]
        self.moveset << [y - 1, x + 1]
        self.moveset << [y - 1, x - 1]
      else
        self.moveset << [y - 1, x]
      end
    else
      if @original_position
        self.moveset << [y + 2, x]
        self.moveset << [y + 1, x]
        self.moveset << [y + 1, x + 1]
        self.moveset << [y + 1, x - 1]
      else
        self.moveset << [y + 1, x]
      end
    end
  end

end