# Outline:
#   1. Build general sudoku CoverSet (reduce sudoku to exact cover problem) once
#   2. For each sudoku on input:
#     a. parse
#     b. cover givens in CoverSet
#     c. find exact cover
#     d. make corresponding placements into a copy of the sudoku
#     e. uncover givens in reverse order to restore general sudoku CoverSet
#
# The trick here is to build the sudoku CoverSet (matrix) only once and restore
# it after each use, as building it in the first place is an expensive
# operation due to the many allocations. (This could probably be tuned further
# by pooling the nodes in CoverSet.)
#
# Reusing a general sudoku CoverSet instead of building a specialized one for
# each sudoku cuts the running time from ~44s to ~7s on my machine, even though
# the individual CoverSets would have been smaller.

require("lib/ExactCovers.jl")
using ExactCovers

box_for(row, column) = (div(row - 1, 3) + 1, div(column - 1, 3) + 1)

function constraints_for(row, column, number)
  box = box_for(row, column)

  [
    (:square_is_filled, row, column),
    (:row_has, row, number),
    (:column_has, column, number),
    (:box_has, box_for(row, column), number)
  ]
end

function make_options()
  options = CoverSet()

  for row = 1:9, column = 1:9, number = 1:9
    option = (row, column, number)
    push!(options, constraints_for(option...), key = option)
  end

  options
end

function cover_givens!(sudoku, options)
  for row = 1:9, column = 1:9
    if sudoku[row, column] > 0
      cover_subset!(options, (row, column, sudoku[row, column]))
    end
  end
end

function uncover_givens!(sudoku, options)
  for row = 9:-1:1, column = 9:-1:1
    if sudoku[row, column] > 0
      uncover_subset!(options, (row, column, sudoku[row, column]))
    end
  end
end

function solve(sudoku, options)
  result = copy(sudoku)
  cover_givens!(sudoku, options)
  for entry in find_exact_cover(options)
    row, column, number = entry
    result[row, column] = number
  end
  uncover_givens!(sudoku, options)
  
  result
end

sudoku_producer(filename) = @task let
  file = open(filename)
  while !eof(file)
    readline(file)
    sudoku = Array(Int8, 9, 9)
    for row = 1:9
        sudoku[row, :] =  map(c -> c - '0', readbytes(file, 9))
        readline(file)
    end

    produce(sudoku)
  end
end

let
  result = 0
  options = make_options()
  for sudoku in sudoku_producer("p096_sudoku.txt")
    sudoku = solve(sudoku, options)
    result += 100sudoku[1, 1] + 10sudoku[1, 2] + sudoku[1, 3]
  end
  println(result)
end
