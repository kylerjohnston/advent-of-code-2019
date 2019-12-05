#!/usr/bin/env ruby

class Grid
  attr_reader :routes, :intersections, :distance

  def initialize
    @routes = []
    @intersections = []
  end

  def add_route(step_string)
    steps = step_string.split(',')
    @routes << calculate_route([0, 0], steps.reverse, [[0, 0]])
    if @routes.length > 1
      find_intersections(0, routes.length)
      @distance = find_closest
    end
  end

  private
  def calculate_route(start, steps, route)
    x = start[0]
    y = start[1]

    if steps.length == 0
      return route
    else
      step = steps.pop
      next_step = step[1..].to_i
      direction = step[0]
      case direction
      when "U"
        stop_point = y + next_step
        while y < stop_point
          y += 1
          route << [x, y]
        end
      when "D"
        stop_point = y - next_step
        while y > stop_point
          y -= 1
          route << [x, y]
        end
      when "R"
        stop_point = x + next_step
        while x < stop_point
          x += 1
          route << [x, y]
        end
      when "L"
        stop_point = x - next_step
        while x > stop_point
          x -= 1
          route << [x, y]
        end
      end
      calculate_route([x, y], steps, route)
    end
  end

  private
  def find_intersections(start, finish)
    if start + 1 >= finish
      return nil
    else
      @routes[start].each do |x|
        @routes[start + 1].each do |y|
          puts "Testing #{x} and #{y}"
          if x == y and x != [0, 0]
            @intersections << x
          end
        end
      end
      find_intersections(start + 1, finish)
    end
  end

  private
  def find_closest
    lowest = nil
    @intersections.each do |x|
      distance = x[0].to_i.abs + x[1].to_i.abs
      if lowest == nil
        lowest = distance
      elsif lowest > distance
        lowest = distance
      end
    end
    return lowest
  end
end
