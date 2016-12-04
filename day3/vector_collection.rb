require 'rspec/autorun'
require_relative 'instructions.rb'

class VectorCollection

  def initialize vector_set
    @vectors = vector_set
  end

  def valid_triangle_count
    count = 0
    @vectors.each do |vector|
      count += 1 if valid_triangle?(vector)
    end
    count
  end

  def valid_triangle? r
    (r[0] + r[1] > r[2]) && (r[0] + r[2] > r[1]) && (r[1] + r[2] > r[0])
  end
end

describe VectorCollection do
  describe "#valid_triangle_count" do
    it "returns the number of valid triangle in a collection" do
      instruction_string = "5  10  14
                            2  10  100
                            10 10  10"

      vector_set = Instructions.new(instruction_string).parsed
      vector_collection = VectorCollection.new(vector_set)
      expect(vector_collection.valid_triangle_count).to eq(2)
    end
  end
end
