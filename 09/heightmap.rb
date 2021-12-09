require 'byebug'

class Heightmap
  attr_reader :map
  def initialize(map)
    @map = map
  end

  def lowest_points
    array_map = []
    lowest = []
    File.open(map).each do |line|
      array_map << line.strip.split("").map(&:to_i)
    end
    array_map.each_with_index do |array_x, y|
      array_x.each_with_index do |value, x|
        # ys = [y-1, y, y+1].select{|n| n >= 0 && n <= (array_map.size - 1)}
        # xs = [x-1, x, x + 1].select{|n| n >= 0 && n <= (array_map[y].size - 1)}
        # positions = ys.product(xs)
        # positions.delete([y, x])
        x_size = array_map[y].size - 1
        y_size = array_map.size - 1
        positions = [[y-1, x], [y, x-1], [y, x+1], [y+1,x]].select{|y,x| x >= 0 && y >= 0 && x <= x_size && y <= y_size}
        nearby = positions.map{|new_y, new_x| array_map[new_y][new_x] }
        lowest << value if nearby.all?{|n| value < n}
      end
    end
    lowest.sum + lowest.count
  end
end

puts "Part 1: #{Heightmap.new("map.txt").lowest_points}"
