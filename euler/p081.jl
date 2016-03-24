const Node = Tuple{Int, Int}

function search(values, start, goal, neighbors, h)
  # Vanilla A*
  closed = Set{Node}()
  optima = Dict(start => values[start...])
  frontier = Collections.PriorityQueue(Node, Int)
  frontier[start] = optima[start] + h(start)

  while !isempty(frontier)
    current = Collections.dequeue!(frontier)
    push!(closed, current)
    if current == goal
      return optima[current]
    end

    for neighbor in neighbors(current)
      if neighbor in closed
        continue
      end
      cost = optima[current] + values[neighbor...]
      if !haskey(frontier, neighbor) || cost < get(optima, neighbor, typemax(Int))
        optima[neighbor] = cost
        frontier[neighbor] = cost + h(neighbor)
      end
    end
  end
end

let
  values = readdlm(open("p081_matrix.txt"), ',', Int)
  grid_size = size(values)

  start = (1, 1)
  goal = grid_size

  neighbors(node::Node) = @task let
    x, y = node
    if x < grid_size[1]
      produce(x + 1, y)
    end
    if y < grid_size[2]
      produce(x, y + 1)
    end
  end

  h(a::Node) = grid_size[1] - a[1] + grid_size[2] - a[2]

  result = search(values, start, goal, neighbors, h)
  println(result)
end
