require_relative 'employee'

class Manager < Employee

  def initialize(subordinates)
    @subordinates = subordinates
  end
end