const filename = "p022_names.txt"

value(name) = sum(c -> c - ('A' - 1), name)

function score(entry)
  i, name = entry
  i * value(name)
end

let
  data = split(filename |> open |> readstring, ",")
  sort!(data)
  result = sum(score, enumerate(data))
  println(result)
end
