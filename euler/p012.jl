const n = 500

divisor_count(n) = n |>
  factor |>
  values |>
  x -> foldl((y, z) -> y * (z + 1), 1, x)

let
  triangle = i = 1
  while true
    divisor_count(triangle) > n && break
    triangle += (i += 1)
  end

  println(triangle)
end
