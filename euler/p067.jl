let
  data = map(
    x -> map(int, split(x)),
    open("p067_data.txt") |> eachline
  )
  
  # Dynamic programming
  maxima = data[length(data)]
  for i = (length(data) - 1):-1:1, j = 1:i
    maxima[j] = data[i][j] + max(maxima[j], maxima[j + 1])
  end

  println(maxima[1])
end
