require "rspec/autorun"
require_relative "instructions.rb"

class DestinationFinder

  def initialize instructions
    @instructions = instructions.sequence
    @starting_position = [0,0,:north]
  end

  def destination
    navigate_to_destination(@starting_position, @instructions)
  end

  def first_intersection
    visited_vertices_along_instructions(@starting_position, @instructions)
  end
    
  private

  VECTOR_TRANSLATOR = {
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

  def find_first_intersection

  end
  def visited_vertices_along_instructions position, instructions
    visits = []
    instructions.each do |instruction|
      adjustment_vector = VECTOR_TRANSLATOR[position[2]][instruction[0]]
      current_position = [position[0],position[1]]
      instruction[1].times do |i|
        visits << [current_position[0] + (adjustment_vector[0] * i), current_position[1] + (adjustment_vector[1] * i)]
      end
      position[0] += adjustment_vector[0] * instruction[1]
      position[1] += adjustment_vector[1] * instruction[1]
      position[2] = adjustment_vector[2]
    end
    visits.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first)[0]
  end

  def navigate_to_destination position, instructions
    instructions.each do |instruction|
      adjustment_vector = VECTOR_TRANSLATOR[position[2]][instruction[0]]
      position[0] += adjustment_vector[0] * instruction[1]
      position[1] += adjustment_vector[1] * instruction[1]
      position[2] = adjustment_vector[2]
    end
    [position[0],position[1]]
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

  describe "#first_intersection" do
    it "returns the first time you cross your own path when following directions" do
      instruction_string = "R8, R4, R4, R8"
      instructions = Instructions.new(instruction_string)
      destination_finder = DestinationFinder.new(instructions)

      expect(destination_finder.first_intersection).to match_array([4,0])
    end
  end
end
