require 'byebug'

class DigitsCounter
  attr_reader :entries
  def initialize(entries)
    @entries = entries
  end

  def run
    segments = {}
    result = 0
    File.open(entries).each do |line|
      next if line.strip.empty?
      first = line.strip.split(" | ").first.split(' ')
      segments["1"] = first.find{|i| i.size == 2}
      first.delete(segments["1"])
      segments["7"] = first.find{|i| i.size == 3}
      first.delete(segments["7"])
      segments["4"] = first.find{|i| i.size == 4}
      first.delete(segments["4"])
      segments["8"] = first.find{|i| i.size == 7}
      first.delete(segments["8"])
      segments["5"] = first.select do |item| 
        item.size == 5 && (segments["4"].split('') - segments["1"].split('')).all?{|s| item.split('').include?(s) }
      end.first
      first.delete(segments["5"])
      segments["3"] = first.select do |item| 
        item.size == 5 &&  (item.split('') - segments["5"].split('')).size == 1
      end.first
      first.delete(segments["3"])
      segments["2"] = first.select do |item| 
        item.size == 5
      end.first
      first.delete(segments["2"])
      segments["0"] = first.select do |item|
        !item.split('').include?((segments["2"].split('') & segments["5"].split('') & segments["4"].split('')).first)
      end.first
      first.delete(segments["0"])
      segments["9"]  = first.select do |item|
        segments["1"].split('').all?{|n| item.split('').include?(n)}
      end.first
      first.delete(segments["9"])
      segments["6"] = first.first

      last = line.strip.split(" | ").last.split(' ')
      digits = last.map do |digit|
        segments.select{|k,v| v.split('').sort == digit.split('').sort }.keys.first
      end
      result = result + digits.join.to_i
    end
    result
  end
end

puts "Part 1: #{DigitsCounter.new("input.txt").run}"
