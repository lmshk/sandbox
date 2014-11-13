function diagonals(n)
  layers = div(n, 2) + 1
  sum = inside = 1
  for layer = 1:(layers - 1)
    sum += 4 * inside + 20 * layer
    inside += 8 * layer
  end
  
  return sum
end

println(diagonals(1001))
