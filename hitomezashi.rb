#! /usr/bin/env ruby
#
# Hitomezashi Pattern Creator
# Sam Craig

SCALE = 10

COLUMNS = Array.new(rand(30)).map { rand(2) }
ROWS = Array.new(rand(30)).map { rand(2) }

TOP = ROWS.size * SCALE
RIGHT = COLUMNS.size * SCALE

COLUMN_CODE = COLUMNS.map.with_index do |c, i|
  on = c == 1
  paths = []

  ROWS.size.times do |t|
    if on
      x = i * SCALE
      y = TOP - (t * SCALE)

      paths << %(
        newpath
          #{x} #{y} moveto
          #{x} #{y - SCALE} lineto

        stroke
      )
    end

    on = !on
  end

  paths
end

ROW_CODE = ROWS.map.with_index do |r, i|
  on = r == 1
  paths = []

  COLUMNS.size.times do |t|
    if on
      x = RIGHT - (t * SCALE)
      y = i * SCALE

      paths << %(
        newpath
          #{x} #{y} moveto
          #{x - SCALE} #{y} lineto

        stroke
      )
    end

    on = !on
  end

  paths
end

puts %(
%!PS-Adobe-3.0 EPSF-3.0
%%BoundingBox: -5 -5 #{RIGHT + 5} #{TOP + 5}

0 0 translate

0.0 setgray

1 setlinejoin
1 setlinecap

#{COLUMN_CODE.join("\n")}
#{ROW_CODE.join("\n")}

showpage
)
