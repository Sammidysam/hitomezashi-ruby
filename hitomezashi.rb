#! /usr/bin/env ruby
#
# Hitomezashi Pattern Creator
# Sam Craig

SCALE = 10

LINES = [Array.new(6).map { rand(2) }, Array.new(3).map { rand(2) }]
#[Array.new(rand(30)).map { rand(2) }, Array.new(rand(30)).map { rand(2) }]
BOUNDARIES = LINES.map { |l| (l.size - 1) * SCALE }

LINES_CODE = LINES.map.with_index do |l, i|
  l.map.with_index do |inner, index|
    on = inner == 1
    paths = []

    other_index = -i + 1
    other_lines = LINES[other_index]

    (other_lines.size - 1).times do |t|
      if on
        possibilities = [
          index * SCALE,
          BOUNDARIES[other_index] - (t * SCALE)
        ]

        values = [
          possibilities[0] * other_index + possibilities[1] * i,
          possibilities[0] * i + possibilities[1] * other_index
        ]

        paths << %(
          newpath
            #{values[0]} #{values[1]} moveto
            #{values[0] - SCALE * i} #{values[1] - SCALE * other_index} lineto

          stroke
        )
      end

      on = !on
    end

    paths
  end
end

puts %(
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: -5 -5 #{BOUNDARIES[0] + 5} #{BOUNDARIES[1] + 5}

0 0 translate

0.0 setgray

1 setlinejoin
1 setlinecap

#{LINES_CODE.join("\n")}

showpage
)
