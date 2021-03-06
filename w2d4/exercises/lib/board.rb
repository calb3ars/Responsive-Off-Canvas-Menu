class Board
  attr_accessor :grid

  def self.blank_grid
    Array.new(3) { Array.new(3) }
  end

  def initialize(grid = Board.blank_grid)
    @grid = grid
    @marks = [:X, :O]
  end

  def place_mark(pos, mark)
    @grid[pos] = mark
  end

  def [](pos)
    row, col = pos
    @grid[pos][pos]
  end

  def []=(pos, value)
    row, col = pos
    @grid[pos][pos] = value
  end

  def empty?(pos)
    @grid[pos].nil?
  end

  def over?
    @grid.flatten.none? {|pos| pos.nil?} || winner
  end

  def winner?
    (@grid + cols + diagonals).each do |triple|
      return :X if triple == [:X,:X,:X]
      return :O if triple == [:O,:O,:O]
    end

    nil
  end

  def cols
    cols = [[],[],[]]
    @grid.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end
    end

    cols
  end

  def diagonals
    down_diag = [[0,0],[1,1],[2,2]]
    up_diag = [[0,2],[1,1],[0,2]]

    [down_diag, up_diag].map do |diag|
      diag.map {|row, col| grid[row][col]}
    end
end
