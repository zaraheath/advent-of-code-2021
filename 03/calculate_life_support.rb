require 'byebug'
class CalculateLifeSupport
  def self.run(**args)
    new(**args).run
  end

  attr_reader :entries_file
  def initialize(entries_file:)
    @entries_file = entries_file
  end

  def run
    entries = []
    File.open(entries_file).each do |line|
      entries << line.strip.split("")
    end
    
    get_value(entries.dup, :max, "1") * get_value(entries.dup, :min, "0")
  end

private
  def get_value(array, filter_method, equal_default)
    transposed_array = array.transpose
    0.upto(transposed_array.size - 1).each do |index|
      counts = transposed_array[index].tally
      searched_value = if counts.values.uniq.size == 1
        equal_default
      else
        counts.select{|_, v| v == counts.values.send(filter_method)}.keys.first
      end
      array = array.select {|e| e[index] == searched_value }
      break if array.size == 1
      transposed_array = array.transpose
    end
    array.first.join.to_i(2)
  end
end

puts "Part 2: #{CalculateLifeSupport.run(entries_file: "diagnostic_report.txt")}"
