require 'byebug'

class DigitsCounter
  attr_reader :entries
  def initialize(entries)
    @entries = entries
  end

  def run
    segments = {
      2 => 1,
      3 => 7,
      4 => 4,
      7 => 8
    }
    result = 0
    File.open(entries).each do |line|
      next if line.strip.empty?
      sizes = line.strip.split(" | ").last.split(' ').map(&:size)
      result = result + sizes.select{|n| segments.keys.include?(n)}.count
    end
    result
  end
end

puts "Part 1: #{DigitsCounter.new("input.txt").run}"
