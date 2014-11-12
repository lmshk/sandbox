function stepsum(n, step)
  count = div(n, step)
  step * div(count * (count + 1), 2)
end

const n = 999
result = stepsum(n, 3) + stepsum(n, 5) - stepsum(n, 3 * 5)
println(result)
