pythagoras(a, b, c) = c^2 == a^2 + b^2
b_from(a, n) = div(div(n^2, 2) - n * a, n - a)
c_from(a, b, n) = n - a - b

let
  n = 1000
  for a = 1:n
    b = b_from(a, n)
    c = c_from(a, b, n)
    (b > 0 && c > 0) || continue
    if pythagoras(a, b, c)
      println(a * b * c)
      break
    end
  end
end
