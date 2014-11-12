even_fibonacci_numbers_up_to(n) = @task let
  window = [2, 1]
  step = [1 1; 1 0]^3
  while window[1] <= n
    produce(window[1])
    window = step * window
  end
end

even_fibonacci_numbers_up_to(4000000) |> sum |> println
