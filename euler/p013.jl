(
  Base.mapfoldl(BigInt, push!, BigInt[], open("p013_data.txt") |> eachline) |>
  sum |>
  string
)[1:10] |> println
