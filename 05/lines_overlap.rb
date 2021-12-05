require 'byebug'

class LinesOverlap
  attr_reader :coordinates_file
  def initialize(coordinates_file:)
    @coordinates_file = coordinates_file
  end

  def get
    coordinates = []
    max_x = 0
    max_y = 0
    File.open(coordinates_file).each do |line|
      next if line.strip.empty?
      coordinates_txt = line.strip.split(" -> ")
      x1, y1 = coordinates_txt.first.split(',').map(&:to_i)
      x2, y2 = coordinates_txt.last.split(',').map(&:to_i)
      max_y = [y1, y2].max if [y1, y2].max > max_y
      max_x = [x1, x2].max if [x1, x2].max > max_x
      if x1 == x2
        # verical line
        min = [y1, y2].min
        max = [y1, y2].max
        min.upto(max) do |y|
          coordinates << [x1, y]
        end
      elsif y1 == y2
        # horizontal line
        min = [x1, x2].min
        max = [x1, x2].max
        min.upto(max) do |x|
          coordinates << [x, y1]
        end
      end
    end
    diagram = []
    (max_y + 1).times { diagram << Array.new((max_x + 1), 0) }
    coordinates.each do |x, y|
      diagram[y][x] = diagram[y][x] + 1
    end
    count = 0
    diagram.each do |line|
      count = count + line.count{|i| i >= 2}
    end
    count
  end
end

puts "Part 1: #{LinesOverlap.new(coordinates_file: "coordinates.txt").get}"


