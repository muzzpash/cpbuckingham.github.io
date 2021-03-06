##
# Define additional spec pieces outside the generated data
module SVGPlot
  ##
  # Aliases for common tags
  SVG_ALIAS = {
    group: :g,
    rectangle: :rect
  }

  ##
  # Generic lambda for adding points, used below
  POINT_LAMBDA = lambda do |args|
    if args.length.odd?
      fail ArgumentError 'Illegal number of coordinates (should be even)'
    end
    { points: args.each_slice(2).map { |x| x.join(',') }.join(' ') }
  end

  ##
  # Expansion definitions for unnamed args
  SVG_EXPANSION = {
    line: [:x1, :y1, :x2, :y2],
    circle: [:cx, :cy, :r],
    image: [:x, :y, :width, :height, :'xlink:href'],
    ellipse: [:cx, :cy, :rx, :ry],
    text: [:x, :y],
    rect: lambda do |args|
      unless [4, 5, 6].include? args.size
        fail ArgumentError 'Wrong unnamed argument count'
      end
      result = Hash[[:x, :y, :width, :height].zip(args)]
      if args.size > 4
        result[:rx] = args[4]
        result[:ry] = args[5] || args[4]
      end
      result
    end,
    polygon: POINT_LAMBDA,
    polyline: POINT_LAMBDA
  }

  ##
  # Define processing for Expansion constants
  module Expansion
    def expand(tag, args)
      expansion = SVG_EXPANSION[tag.to_sym]
      fail("Unnamed parameters for #{tag} are not allowed!") unless expansion

      if expansion.is_a? Array
        parse_args(tag, expansion, args)
      elsif expansion.is_a? Proc
        expansion.call(args)
      else
        fail "Unexpected expansion mechanism: #{expansion.class}"
      end
    end
  end
end
