"p013_data.txt" |>
  open |>
  eachline |>
  line -> map(number -> parse(BigInt, number), line) |>
  sum |>
  string |>
  result -> result[1:10] |>
  println
