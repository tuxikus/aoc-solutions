class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
end

def calc_rect(r_1, r_2)
  width = r_2.x - r_1.x + 1
  heigth = r_2.y - r_1.y + 1
  return width * heigth
end

input = File.read("input.txt")
points = []

input.each_line do |line|
  parts = line.split(",")
  x = parts[0].strip.to_i
  y = parts[1].strip.to_i
  points << Point.new(x, y)
end

biggest = -1
for point_1 in points
  for point_2 in points
    if calc_rect(point_1, point_2) > biggest
      biggest = calc_rect(point_1, point_2)
    end 
   end
end

puts biggest
