function iterate(n::Int)
  result = 0
  while n > 0
    n, last = divrem(n, 10)
    result += last * last
  end
  return result
end

const cache = [1 => false, 89 => true]
function eightynine(n::Int)
  n = iterate(n)
  if !haskey(cache, n)
    cache[n] = eightynine(n)
  end
  return cache[n]
end

println(count(n -> eightynine(n), 1:9999999))
