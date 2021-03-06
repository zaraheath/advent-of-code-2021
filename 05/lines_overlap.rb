require 'byebug'

class LinesOverlap
  attr_reader :coordinates_file, :diagonal
  def initialize(coordinates_file:, diagonal: false)
    @coordinates_file = coordinates_file
    @diagonal = diagonal
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
      elsif diagonal
        #diagonal line
        if x1 > x2 && y1 > y2
          # drecrement bothm 
          [x1.downto(x2).to_a, y1.downto(y2).to_a].transpose.each{|a| coordinates << a}
        elsif x1 > x2 && y1 < y2
          # decrement x, increment y
          [x1.downto(x2).to_a, y1.upto(y2).to_a].transpose.each{|a| coordinates << a}
        elsif x1 < x2 && y1 < y2
          # increment both
          [x1.upto(x2).to_a, y1.upto(y2).to_a].transpose.each{|a| coordinates << a}
        elsif x1 < x2 && y1 > y2
          # increment x, decrement y
          [x1.upto(x2).to_a, y1.downto(y2).to_a].transpose.each{|a| coordinates << a}
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
puts "Part 2: #{LinesOverlap.new(coordinates_file: "coordinates.txt", diagonal: true).get}"


