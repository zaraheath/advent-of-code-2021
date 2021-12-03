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
    
    oxygen_rating = entries.dup
    oxygen_transposed = oxygen_rating.transpose
    0.upto(oxygen_transposed.size - 1).each do |index|
      counts = oxygen_transposed[index].tally
      most_common = counts.select{|_, v| v == counts.values.max }.keys.first
      less_common = counts.select{|_, v| v == counts.values.min }.keys.first
      most_common = "1" if most_common == less_common
      oxygen_rating = oxygen_rating.select {|e| e[index] == most_common }
      break if oxygen_rating.size == 1
      oxygen_transposed = oxygen_rating.transpose
    end

    co2_rating = entries.dup
    co2_transposed = co2_rating.transpose
    0.upto(co2_transposed.size - 1).each do |index|
      byebug if co2_transposed[index].nil?
      counts = co2_transposed[index].tally
      most_common = counts.select{|_, v| v == counts.values.max }.keys.first
      less_common = counts.select{|_, v| v == counts.values.min }.keys.first
      less_common = "0" if most_common == less_common
      co2_rating = co2_rating.select {|e| e[index] == less_common }
      break if co2_rating.size == 1
      co2_transposed = co2_rating.transpose
    end
    oxygen_rating.first.join.to_i(2) * co2_rating.first.join.to_i(2)
  end
end

puts "Part 2: #{CalculateLifeSupport.run(entries_file: "diagnostic_report.txt")}"
