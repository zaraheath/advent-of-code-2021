require 'byebug'

class LanternfishCounter
  attr_reader :initial, :days
  def initialize(initial:, days:)
    @initial = initial
    @days = days
  end

  def count
    lanternfish_hash = {}
    initial.each do |timer|
      lanternfish_hash[timer] = 0 if lanternfish_hash[timer].nil?
      lanternfish_hash[timer] = lanternfish_hash[timer] + 1
    end
    days.times do
      aux = {}
      8.downto(1).each do |i|
        aux[i-1] = lanternfish_hash[i]
      end
      if !lanternfish_hash[0].nil? && lanternfish_hash[0] > 0
        # new lanternfish
        aux[8] = lanternfish_hash[0]
        aux[6] = aux[6].to_i + lanternfish_hash[0]
      end
      lanternfish_hash = aux
    end
    lanternfish_hash.values.sum
  end
end

initial_list = [1,1,1,1,2,1,1,4,1,4,3,1,1,1,1,1,1,1,1,4,1,3,1,1,1,5,1,3,1,4,1,2,1,1,5,1,1,1,1,1,1,1,1,1,1,3,4,1,5,1,1,1,1,1,1,1,1,1,3,1,4,1,1,1,1,3,5,1,1,2,1,1,1,1,4,4,1,1,1,4,1,1,4,2,4,4,5,1,1,1,1,2,3,1,1,4,1,5,1,1,1,3,1,1,1,1,5,5,1,2,2,2,2,1,1,2,1,1,1,1,1,3,1,1,1,2,3,1,5,1,1,1,2,2,1,1,1,1,1,3,2,1,1,1,4,3,1,1,4,1,5,4,1,4,1,1,1,1,1,1,1,1,1,1,2,2,4,5,1,1,1,1,5,4,1,3,1,1,1,1,4,3,3,3,1,2,3,1,1,1,1,1,1,1,1,2,1,1,1,5,1,3,1,4,3,1,3,1,5,1,1,1,1,3,1,5,1,2,4,1,1,4,1,4,4,2,1,2,1,3,3,1,4,4,1,1,3,4,1,1,1,2,5,2,5,1,1,1,4,1,1,1,1,1,1,3,1,5,1,2,1,1,1,1,1,4,4,1,1,1,5,1,1,5,1,2,1,5,1,1,1,1,1,1,1,1,1,1,1,1,3,2,4,1,1,2,1,1,3,2]

puts "Part 1: #{LanternfishCounter.new(initial: initial_list, days: 80).count}"


