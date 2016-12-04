require 'rspec/autorun'

class Instructions

  attr_reader :parsed

  def initialize(instruction_string)
    @parsed = translate instruction_string
  end

  def part2
    vertical_translation
  end

  def other
    @parsed
  end

  def translate instruction_string
    instruction_string.split("\n").map(&:split).map{|sa| sa.map(&:to_i)}
  end

  def vertical_translation
    translation = []
    triplets = @parsed.count / 3
    triplets.times do |i|
      si = i * 3
      3.times do |a|
        translation << [@parsed[si][a], @parsed[si+1][a], @parsed[si+2][a]]
        # t << [instructions.parsed[si][a], instructions.parsed[si+1][a], instructions.parsed[si+2][a]]
      end
    end
    translation
  end
end

describe Instructions do
  describe "#parsed" do
    it "returns a collection of vector lengths" do
      instruction_string = "  775  785  361
        622  375  125"
      instructions = Instructions.new(instruction_string)
      expect(instructions.parsed).to match_array([[775,785,361],[622,375,125]])
    end
  end

  describe "#part2" do
    it "returns a collection of vector lengths vertically" do
      instruction_string = "  775  785  361
        622  375  125
        111  222  333"
      instructions = Instructions.new(instruction_string)
      expect(instructions.part2).to match_array([[775,622,111],[785,375,222],[361,125,333]])
    end
  end
end

# [1, 2, 3]
# [4, 5, 6]
# [7, 8, 9]

# [1,4,7]
# [2,5,8]
# [3,6,9]

