let
  n = 4
  data = readdlm(open("p011_data.txt"), Uint8)

  products = [
    (x, y) -> prod(data[x:(x + n - 1), y]),
    (x, y) -> prod(data[x, y:(y + n - 1)]),
    (x, y) -> mapreduce(
      i -> data[x + i, y + i],
      *,
      0:(n - 1)
    ),
    (x, y) -> mapreduce(
      i -> data[x + n - 1 - i, y + i],
      *,
      0:(n - 1)
    )
  ]

  result = 0
  last_row = size(data, 1) - (n - 1)
  last_column = size(data, 2) - (n - 1)
  for i = 1:last_row, j = 1:last_column, f in products
    result = max(result, f(i, j))
  end

  println(result)
end
