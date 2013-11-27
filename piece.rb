class Piece
  attr_reader :color
  attr_accessor :position, :moveset

  def initialize(position)
    @captured = 0
    @position = position
    @moveset = []
  end

  def set_color(color)
    @color = color
  end

  def whittle
    self.moveset.select! do |move|
      move[0] > -1 && move[0] < 8 && move[1] > -1 && move[1] < 8
    end
  end

end

