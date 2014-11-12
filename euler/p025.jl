let
  n = 2
  previous = current = big(1)
  while ndigits(current) < 1000
    previous, current = current, previous + current
    n += 1
  end

  println(n)
end
