require 'byebug'

class BingoGame
  attr_reader :boards_file, :numbers
  def initialize(numbers:, boards_file:)
    @boards_file = boards_file
    @numbers = numbers
  end

  def play_first
    boards = {}
    num_board = 0
    num_line = 0
    File.open(boards_file).each do |line|
      if line == "\n"
        num_board = num_board + 1
        num_line = 0
      else
        line.split(" ").map(&:to_i).each_with_index do |number, i|
          boards[num_board] = {} if boards[num_board].nil?
          boards[num_board][number] = { line: num_line, column: i}
        end
        num_line = num_line + 1
      end
    end
    winner = nil
    last_number = nil
    numbers.each do |drawn_number|
      boards.each do |num, board|
        unless board[drawn_number].nil?
          board[drawn_number][:marked] = true
          marked_numbers = board.select{|k, h| h[:marked] }
          complete_line = marked_numbers.values.map{|h| h[:line]}.tally.any?{|k, v| v == 5 }
          complete_column = marked_numbers.values.map{|h| h[:column]}.tally.any?{|k, v| v == 5 }
          if complete_column || complete_line
            winner = board
            break
          end
        end
      end
      if winner
        last_number = drawn_number
        break
      end
    end

    calculate_score(winner, last_number)
  end

  def play_last
    boards = {}
    num_board = 0
    num_line = 0
    File.open(boards_file).each do |line|
      if line == "\n"
        num_board = num_board + 1
        num_line = 0
      else
        line.split(" ").map(&:to_i).each_with_index do |number, i|
          boards[num_board] = {} if boards[num_board].nil?
          boards[num_board][number] = { line: num_line, column: i}
        end
        num_line = num_line + 1
      end
    end
    winner = nil
    winners = []
    last_number = nil
    numbers.each do |drawn_number|
      boards.each do |num, board|
        unless board[drawn_number].nil?
          board[drawn_number][:marked] = true
          marked_numbers = board.select{|k, h| h[:marked] }
          complete_line = marked_numbers.values.map{|h| h[:line]}.tally.any?{|k, v| v == 5 }
          complete_column = marked_numbers.values.map{|h| h[:column]}.tally.any?{|k, v| v == 5 }
          if complete_column || complete_line
            winner = true
            winners << board.dup
            boards.delete(num)
          end
        end
      end
      if winner
        last_number = drawn_number
        winner = false
      end
    end

    calculate_score(winners.last, last_number)
  end

private

  def calculate_score(winner, last_number)
    winner.select{|k, h| h[:marked].nil? }.keys.sum * last_number
  end
end

numbers = [31,88,35,24,46,48,95,42,18,43,71,32,92,62,97,63,50,2,60,58,74,66,15,87,57,34,14,3,54,93,75,22,45,10,56,12,83,30,8,76,1,78,82,39,98,37,19,26,81,64,55,41,16,4,72,5,52,80,84,67,21,86,23,91,0,68,36,13,44,20,69,40,90,96,27,77,38,49,94,47,9,65,28,59,79,6,29,61,53,11,17,73,99,25,89,51,7,33,85,70]

puts "Part 1: #{BingoGame.new(numbers: numbers, boards_file: "boards.txt").play_first}"
puts "Part 2: #{BingoGame.new(numbers: numbers, boards_file: "boards.txt").play_last}"


