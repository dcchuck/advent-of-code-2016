require 'rspec/autorun'

class Instructions
  attr_accessor :parsed

  def initialize instruction_string
    @parsed = parse(instruction_string)
  end

  private

  def parse instruction_string
    instruction_string.split("\n").map{|e| e.split(//)}.map{|a| a.map(&:to_sym)}
  end

end

describe Instructions do
  describe "#parsed" do
    it "returns the parsed instructions as an array by button" do
      instruction_string = "UL\nRR\nDU"
      instructions = Instructions.new(instruction_string)

      expect(instructions.parsed).to match_array([[:U, :L],[:R, :R],[:D,:U]])
    end
  end
end
