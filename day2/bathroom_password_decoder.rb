require 'rspec/autorun'
require_relative 'instructions.rb'

class BathroomPasswordDecoder

  attr_reader :bathroom_password
  attr_reader :complex_password

  def initialize instructions
    @instructions = instructions
    @starting_position = 5
    @bathroom_password = follow(@instructions)
    @complex_password = complex_follow(@instructions)
  end

  private

  COMPLEX_PAD = {
  one: {
    U: :one,
    D: :three,
    L: :one,
    R: :one
  },
  two: {
    U: :two,
    D: :six,
    L: :two,
    R: :three
  },
  three: {
    U: :one,
    D: :seven,
    L: :two,
    R: :four
  },
  four: {
    U: :four,
    D: :eight,
    L: :three,
    R: :four
  },
  five: {
    U: :five,
    D: :five,
    L: :five,
    R: :six
  },
  six: {
    U: :two,
    D: :a,
    L: :five,
    R: :seven
  },
  seven: {
    U: :three,
    D: :b,
    L: :six,
    R: :eight
  },
  eight: {
    U: :four,
    D: :c,
    L: :seven,
    R: :nine
  },
  nine: {
    U: :nine,
    D: :nine,
    L: :eight,
    R: :nine
  },
  a: {
    U: :six,
    D: :a,
    L: :a,
    R: :b
  },
  b: {
    U: :seven,
    D: :d,
    L: :a,
    R: :c
  },
  c: {
    U: :eight,
    D: :c,
    L: :b,
    R: :c
  },
  d: {
    U: :b,
    D: :d,
    L: :d,
    R: :d
  }
}
  NEXT_BUTTON = [
    {},
    { U: 1,
         D: 4,
         L: 1,
         R: 2 },
    { U: 2,
         D: 5,
         L: 1,
         R: 3 },
    { U: 3,
         D: 6,
         L: 2,
         R: 3 },
    { U: 1,
         D: 7,
         L: 4,
         R: 5 },
    { U: 2,
         D: 8,
         L: 4,
         R: 6 },
    { U: 4,
         D: 9,
         L: 5,
         R: 6 },
    { U: 4,
         D: 7,
         L: 7,
         R: 8 },
    { U: 5,
         D: 8,
         L: 7,
         R: 9 },
    { U: 6,
         D: 9,
         L: 8,
         R: 9 }]

  def follow instructions
    password = []
    current_button = @starting_position
    instructions.each do |button|
      button.each do |direction|
        current_button = NEXT_BUTTON[current_button][direction]
      end
      password << current_button
    end
    password
  end

  def complex_follow instructions
    password = []
    current_button = :five
    instructions.each do |button|
      button.each do |direction|
        current_button = COMPLEX_PAD[current_button][direction]
      end
      password << current_button
    end
    password
  end

end

describe BathroomPasswordDecoder do
  describe "#bathroom_password" do
    it "returns the decoded bathroom code based on a set of instructions" do
      sample_instructions = "ULL\nRRDDD\nLURDL\nUUUUD"
      instructions = Instructions.new(sample_instructions).parsed

      bathroom_password_decoder = BathroomPasswordDecoder.new(instructions)
      expect(bathroom_password_decoder.bathroom_password).to match_array([1, 5, 8, 9])
    end
  end

  describe "#complex_password" do
    it "returns the decoded bathroom code based on a set of instructions" do
      sample_instructions = "ULL\nRRDDD\nLURDL\nUUUUD"
      instructions = Instructions.new(sample_instructions).parsed

      bathroom_password_decoder = BathroomPasswordDecoder.new(instructions)
      expect(bathroom_password_decoder.complex_password).to match_array([:five, :d, :b, :three])
    end
  end
end
