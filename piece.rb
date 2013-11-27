# require_relative 'sliding_piece.rb'
# require_relative 'stepping_piece.rb'

class Piece
  attr_reader :color
  attr_accessor :position, :moveset

  def initialize(position)
    @captured = 0
    @position = position
  end

  def set_color(color)
    @color = color
  end
end