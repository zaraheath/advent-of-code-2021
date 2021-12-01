class IncreaseWindowCounter
  def self.run(**args)
    new(**args).run
  end

  attr_reader :window_size, :entries_file
  def initialize(window_size:, entries_file:)
    @window_size = window_size
    @entries_file = entries_file
  end

  def run
    array_values = []
    File.open(entries_file).each do |line|
      array_values << line.to_i
    end

    previous_sum = 0
    increased = 0
    0.upto(array_values.size - window_size).each do |index|
      current_sum = array_values[index, window_size].sum
      increased = increased + 1 if current_sum > previous_sum && previous_sum != 0
      previous_sum = current_sum
    end
    increased
  end
end

puts "Part 1: #{IncreaseWindowCounter.run(window_size: 3, entries_file: "report.txt")}"


