require "rspec/autorun"
require_relative "instructions.rb"

class DestinationFinder

  def initialize instructions
    @instructions = instructions.sequence
    @starting_position = [0,0,:north]
  end

  def destination
    find_destination(@starting_position, @instructions)
  end

  private

  MOVE_AND_FACE = {
    north: {
      right: [1, 0, :east],
      left: [-1, 0, :west]
    },
    south: {
      right: [-1, 0, :west],
      left: [1, 0, :east]
    },
    east: {
      right: [0, -1, :south],
      left: [0, 1, :north]
    },
    west: {
      right: [0, 1, :north],
      left: [0, -1, :south]
    }
  }

  def find_destination starting_position, instructions
    location = starting_position
    instructions.each do |instruction|
      adjustment_vector = MOVE_AND_FACE[location[2]][instruction[0]]
      location[0] += adjustment_vector[0] * instruction[1]
      location[1] += adjustment_vector[1] * instruction[1]
      location[2] = adjustment_vector[2]
    end
    [location[0],location[1]]
  end
end


describe DestinationFinder do
  describe "#destination" do
    it "returns a relative location as an x, y coordinate" do
      instruction_string = "R1, R2, L3"
      instructions = Instructions.new(instruction_string)
      destination_finder = DestinationFinder.new(instructions)

      expect(destination_finder.destination).to match_array([4,-2])
    end
  end
end
