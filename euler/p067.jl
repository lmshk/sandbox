const filename = "p067_data.txt"

let
  # Unfortunately we need the collects: the first one, because
  # [[1]] == [1] at the moment, and the second one because
  # collect can not handle the unsized iterable returned from
  # eachline. Both will probably change in the future.
  data = [
    collect(parse(Int, number) for number in split(line))
      for line in filename |> open |> eachline |> collect
  ]

  # Dynamic programming
  maxima = data[length(data)]
  for i = (length(data) - 1):-1:1, j = 1:i
    maxima[j] = data[i][j] + max(maxima[j], maxima[j + 1])
  end

  println(maxima[1])
end
