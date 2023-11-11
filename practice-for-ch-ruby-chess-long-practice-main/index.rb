require 'js'
require 'delegate'
require 'singleton'
JS.global[:document].getElementsByTagName('h1')[0][:innerText] = 'Loaded!'

class JSBoard < Board
  attr_accessor :cells
  attr_reader :active_cell

  include Singleton

  def initialize
    super
    # @b_indices = (0..7).map { |i| (0..7).each_with_object(i).to_a }.transpose.flatten(1)
    @cells = Array.new(8) { Array.new(8) }
    setup_table

    # From html
    @active_cell = nil
  end

  def setup_table
    setup_cell = proc do |cell_element, i, j|
      cells[i][j] = cell = Cell.new(cell_element, [i, j])
      cell[:innerText] = self[[i, j]].symbol
      cell[:onclick] = method(:cell_onclick).to_proc.to_js
    end

    iterate_cells = proc do |cell, idx_cell|
      setup_cell.call(cell, JS.global[:idx_row].to_i, idx_cell.to_i)
    end.to_js

    iterate_rows = proc do |row, idx_row|
      JS.global[:idx_row] = idx_row
      JS.global[:Array].call(:from, row[:children]).call(:forEach, iterate_cells)
    end.to_js

    table = JS.global[:document].getElementsByTagName('table').call(:item, 0)
    rows = table[:children].call(:item, 0)[:children]
    JS.global[:Array].call(:from, rows).call(:forEach, iterate_rows)
  end

  def cell_onclick(event)
    clicked_cell = Cell.from_cell_element(event[:target])
    return self.active_cell = clicked_cell if active_cell.nil?
    return self.active_cell = clicked_cell unless active_cell.piece.moves.include?(clicked_cell.pos)

    move_piece(active_cell, clicked_cell)
    self.active_cell = nil
  end

  def active_cell=(new_active_cell)
    # clear old active cell indicator
    active_cell[:classList].call(:remove, 'border-2', 'border-black') unless active_cell.nil?
    # clear green "valid space" indicators
    cells.flatten.each { |c| c[:style][:boxShadow] = '' }

    if new_active_cell.nil?
      p 'wosga!!', active_cell, new_active_cell
      @active_cell = new_active_cell
      return
    end

    # add new active cell indicator
    new_active_cell[:classList].call(:add, 'border-2', 'border-black')
    # add new green "valid space" indicators
    new_active_cell.piece.moves { |c| c[:style][:boxShadow] = '' }

    new_active_cell.piece.moves.each { |i, j| cells[i][j][:style][:boxShadow] = 'inset 0 0 14px #16a34a' }
    @active_cell = new_active_cell
  end

  def move_piece(from, to)
    return false unless super(from.pos, to.pos)

    [from, to].each(&:update_symbol)
  end
end

class Cell < SimpleDelegator
  attr_accessor :pos

  def initialize(element, pos)
    @pos = pos
    super(element)
  end

  def self.from_cell_element(cell_element)
    pos = [cell_element[:parentElement][:rowIndex].to_i, cell_element[:cellIndex].to_i]
    Cell.new(cell_element, pos)
  end

  def piece
    JSBoard.instance[pos]
  end

  def update_symbol
    self[:innerText] = piece.symbol
  end
end

JSBoard.instance
