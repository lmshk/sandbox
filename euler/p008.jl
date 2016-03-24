function read_input(filename)
  data = Int8[]
  for c in open(filename) |> readstring
    '0' <= c <= '9' && push!(data, c - '0')
  end

  data
end

let
  n = 13
  data = read_input("p008_data.txt")

  result = mapreduce(
    i -> prod(data[i:(i + n - 1)]),
    max,
    1:(length(data) - n + 1)
  )

  println(result)
end
