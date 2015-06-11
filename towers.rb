class TowerOfHanoi

  def initialize(tower_height)
    #Instance variables
    @tower_height = tower_height
    @current_board = [[],[],[]]
    @victory_board = [[],[],[]]

    # Creates initial board
    (1..@tower_height).each do |num|

      @current_board[0] << num
      @current_board[1] << 0
      @current_board[2] << 0

    end

    # Victory condition board
    (1..@tower_height).each do |num|

      @victory_board[2] << num
      @victory_board[1] << 0
      @victory_board[0] << 0

    end

  end



  def show_board

    print @current_board

  end



  def show_victory

    print @victory_board

  end



  def render

    @current_board.each do |row|

      print row
      puts''

    end

    @victory_board.each do |row|

      print row
      puts''

    end

    puts "\nCurrent Board:"

    @tower_height.times do |row|

      @current_board.each do |col|

        print "o" * col[row] + (" " * ((@tower_height - col[row]) + 5))

      end

      puts ''

    end

    puts "1" + (" " * (@tower_height + 4) + "2" + (" " * (@tower_height+ 4))) + "3"

  end



  def intro

    #Prints introduction and instructions

    puts "\nWelcome to Tower of Hanoi!"
    puts "Instructions:"
    puts "Enter where you'd like to move from and to"
    puts "in the format [1,3]. Enter 'q' to quit."

  end



  def get_input()

    print "\nEnter move > "

    move_input = gets.chomp

    if move_input == "q"
      exit
    end

    move = [move_input[1].to_i, move_input[3].to_i]

    if !(move[0] > 0 && move[0] < 4) || !(move[1] > 0 && move[1] < 4)
      puts "Invalid entry"
      self.user_move
    end

    move[0] -= 1
    move[1] -= 1

    return move

  end




  def change_board(move)

    # Find first non zero element
    element_to_move = @current_board[move[0]].detect {|value| value > 0}

    # Test to see if entry is valid, restart if invalid
    if element_to_move.nil?

      puts "Invalid Move"
      change_board(self.get_input())

    end

    # Find top element
    test = @current_board[move[1]].detect {|value| value > 0}

    if test.nil?

      # Remove from initial spot
      @current_board[move[0]][@current_board[move[0]].index(element_to_move)] = 0

      @current_board[move[1]].push(element_to_move.to_i)

      @current_board[move[1]].shift

    # Test to see if piece is smaller than one to place on
    elsif element_to_move > test

      puts "Invalid Move"
      change_board(self.get_input())

    else

      # Remove from initial spot
      @current_board[move[0]][@current_board[move[0]].index(element_to_move)] = 0

      # FInd index of next piece, replace index before it
      @current_board[move[1]][@current_board[move[1]].index(test) - 1] = element_to_move.to_i

      if @current_board[move[1]].length > @tower_height

        @current_board[move[1]].shift

      end

    end

  end




  def play()

    self.intro

    until @current_board == @victory_board

      self.render
      change_board(self.get_input())

    end

    puts "You win!"
    exit

  end

end

# -------------------------------------------------------------------

t = TowerOfHanoi.new(3)
t.play