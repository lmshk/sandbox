value(name) = sum(c -> c - ('A' - 1), name)

function score(entry)
  i, name = entry
  i * value(name)
end

let
  data = vec(readdlm(open("p022_names.txt"), ',', String))
  sort!(data)
  result = sum(score, enumerate(data))
  println(result)
end
