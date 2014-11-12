function collatz!(n, cache)
  if !haskey(cache, n)
    cache[n] = 1 +
      if iseven(n)
        collatz!(div(n, 2), cache)
      else
        collatz!(3 * n + 1, cache)
      end
  end

  return cache[n]
end

let
  collatz_cache = [1 => 1]
  max_n, max_length = 0, 0
  for n = 1:999999
    length = collatz!(n, collatz_cache)
    if length > max_length
      max_n = n
      max_length = length
    end
  end

  println(max_n)
end
