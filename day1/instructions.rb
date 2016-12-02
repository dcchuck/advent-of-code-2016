require "rspec/autorun"

class Instructions
  attr_reader :sequence
  def initialize raw_string
    @sequence = convert raw_string
  end

  private

  def convert instruction_string
    steps = split_into_text_array(instruction_string)
    steps.map{|i| i.split('',2)}.map{|d,n| [d == "R" ? :right : :left,n.to_i]}
  end

  def split_into_text_array instruction_string
    instruction_string.split(/\s*,\s*/)
  end

end

# instruction_string = "R1, R3, L2, L5"
# instructions = Instructions.new(instruction_string)
# instructions.sequence => [[:right,1],[:right,3],[:left,2],[:left,5]]
# instructions.sequence[2] == [:left, 2]

describe Instructions do
  describe "#sequence" do
    it "returns a 2 dimensional array of instructions" do
      instruction_string = "R1"
      instructions = Instructions.new(instruction_string)

      expect(instructions.sequence).to match_array([[:right,1]])
    end
  end
end

