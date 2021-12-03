class CalculateConsumption
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
      entries << line.split("")
    end
    gamma_values = entries.transpose
    gamma_rate_binary = ""
    0.upto(gamma_values.size - 1).each do |i|
      subset = gamma_values[i].tally
      gamma_rate_binary << subset.select{|_, v| v == subset.values.max }.keys.first
    end
    gamma_rate = gamma_rate_binary.strip.to_i(2)
    epsilon_rate = gamma_rate_binary.strip.gsub(/[01]/, "0" => "1", "1" => "0").to_i(2)
    gamma_rate * epsilon_rate
  end
end

puts "Part 1: #{CalculateConsumption.run(entries_file: "diagnostic_report.txt")}"


