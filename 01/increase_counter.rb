class IncreaseCounter
  def self.run(**args)
    new(**args).run
  end

  attr_reader :entries_file
  def initialize(entries_file:)
    @entries_file = entries_file
  end

  def run
    increased = 0
    last_value = nil
    File.open(entries_file).each do |line|
      increased = increased + 1 if !last_value.nil? && (line.to_i > last_value)
      last_value = line.to_i
    end
    increased
  end
end

puts "Part 1: #{IncreaseCounter.run(entries_file: "report.txt")}"


