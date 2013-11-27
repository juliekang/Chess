require_relative 'piece.rb'

class Stepping_Piece < Piece

  def initialize(position)
    super(position)
  end

end

class Knight < Stepping_Piece

  def initialize(position)
    super(position)
    define_moveset
  end

  def to_s
    return "\u2658".encode('utf-8') if @color == :white
    "\u265E".encode('utf-8')
  end

  def define_moveset
    x = self.position[1]
    y = self.position[0]

    (-2..2).each do |i|
      (-2..2).each do |j|
        next if i == 0 || j == 0 || i.abs == j.abs
        self.moveset << [y + i, x + j]
      end
    end
    whittle
  end

end

class King < Stepping_Piece

  def initialize(position)
    super(position)
    define_moveset
  end

  def to_s
    return "\u2654".encode('utf-8') if @color == :white
    "\u265A".encode('utf-8')
  end

  def define_moveset
    x = self.position[1]
    y = self.position[0]

    (-1..1).each do |i|
      next if i == 0
      self.moveset << [y + i, x]
      self.moveset << [y, x + i]
      self.moveset << [y + i, x + i]
      self.moveset << [y - i, x + i]
    end
    whittle
  end

end
