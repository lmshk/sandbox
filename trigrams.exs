# Reads a text from standard input, and generates a random stream of words similar in style.
#
# For example:
#   curl -s http://www.gutenberg.org/cache/epub/610/pg610.txt \
#   | awk '/These to His Memory/,/Where all of high and holy dies away./' \
#   | elixir trigrams.exs --count=12 And there

defmodule Trigrams do
  def transform(source, initial) do
    source
    |> to_words
    |> train
    |> generate(initial)
    |> format
  end

  defp to_words(lines) do
    Stream.flat_map(lines, fn line -> Regex.scan(~r/\w+/, line, capture: :first) end)
  end

  defp train(words) do
    words
    |> Stream.chunk(3, 1)
    |> Stream.map(fn [first, second, third] -> {{first, second}, third} end)
    |> map_group_by(fn {first, _} -> first end, fn {_, second} -> second end)
  end

  defp generate(model, start) do
    start
    |> Stream.iterate(fn pair -> sample_next(model, pair) end)
    |> Stream.map(fn {first, _} -> first end)
  end

  defp sample_next(model, pair) do
    choices = model[pair] || Enum.random(Dict.values(model))
    next = Enum.random(choices)
    {_, second} = pair

    {second, next}
  end

  defp format(words) do
    words
    |> Stream.chunk(10)
    |> Stream.map(&(Enum.join(&1, " ")))
  end

  defp map_group_by(enumerable, key_extractor, value_mapper) do
    Enum.reduce(Enum.reverse(enumerable), %{}, fn(entry, categories) ->
      value = value_mapper.(entry)
      Map.update(categories, key_extractor.(entry), [value], &[value | &1])
    end)
  end
end

:random.seed(:os.timestamp)

{[count: count], [first, second], []} =
  OptionParser.parse(System.argv, strict: [count: :integer])

IO.stream(:stdio, :line)
|> Trigrams.transform({first, second})
|> Enum.take(count)
|> Enum.each(&IO.puts/1)
