#require 'engine.rb'
#require_relative 'board.rb'

require './piece.rb'
require './sliding_piece.rb'
require './stepping_piece.rb'
require './pawn.rb'

class Tile
  ALPHA = ("a".."h").to_a
  attr_accessor :color, :name, :piece, :position, :board

  def initialize(position)
    @position = position
    @name = set_name
    @color = set_color
  end

  def set_color
    return :white if (@position[0] + @position[1]) % 2 == 0
    :black
  end

  def set_name
    x = ALPHA[@position[1]]
    y = (8 - @position[0]).to_s
    @name = (x + y).to_sym
  end

  def is_occupied?
    return true if self.piece
    false
  end

  def set_piece(piece)
    @piece = case piece
    when :king
      King.new(self.position)
    when :queen
      Queen.new(self.position)
    when :bishop
      Bishop.new(self.position)
    when :knight
      Knight.new(self.position)
    when :rook
      Rook.new(self.position)
    when :pawn
      Pawn.new(self.position)
    end
  end

  def delete_piece
    @piece = null
  end

  def to_s
    if is_occupied?
      return "#{@piece.to_s} "
    else
      blank = "\u2588".encode('utf-8')
      return "  " if @color == :white
      "#{blank}#{blank}"
    end
  end


end