class CalculatePosition
  def self.run(**args)
    new(**args).run
  end

  attr_reader :entries_file
  def initialize(entries_file:)
    @entries_file = entries_file
  end

  def run
    horizontal = 0
    depth = 0
    File.open(entries_file).each do |line|
      instr, x = line.split(" ")
      case instr
      when "forward"
        horizontal = horizontal + x.to_i
      when "down"
        depth = depth + x.to_i
      when "up"
        depth = depth - x.to_i
      end
    end
    horizontal * depth
  end
end

puts "Part 1: #{CalculatePosition.run(entries_file: "instructions.txt")}"


