#initialize battlefield
def init_battlefield()
  battlefield = Array.new()
  for i in 0..10
    battlefield.push([])
    for j in 0..10
      battlefield[i].push(0)
    end
  end
  return battlefield
end

# checking for free space near new ships positions
def check_space (potential_x_pos, potential_y_pos, battlefield)
  whitespace = [[0,1], [1,0], [0,-1], [-1,0], [1,1], [-1,1], [1,-1], [-1, -1]]
  if potential_x_pos > 0 && potential_x_pos < 11 && potential_y_pos > 0 && potential_y_pos < 11 && battlefield[potential_x_pos][potential_y_pos] == 0
    for i in 0..7
      check_x_position = potential_x_pos + whitespace[i][0];
      check_y_position = potential_y_pos + whitespace[i][1];
      if check_x_position > 0 && check_x_position < 11 && check_y_position > 0 && check_y_position < 11 && battlefield[check_x_position][check_y_position] == 1
        return false
      end
    end
    return true
  else
    return false
  end
end

#creating new ships
def create_ships ();
  battlefield = init_battlefield()
  decks_number = 3
  begin
    for ships_number in 0..(3 - decks_number)
      begin
        potential_x_pos = Random.rand(10) + 1
        potential_y_pos = Random.rand(10) + 1
        is_horizontal_position = Random.rand(2)
        if is_horizontal_position == 0
          is_vertical_position = 1
        else
          is_vertical_position = 0
        end
        b = true
        for i in 0..decks_number
          unless check_space(potential_x_pos + is_horizontal_position * i, potential_y_pos + is_vertical_position * i, battlefield) && (potential_x_pos + is_horizontal_position * i) <= 10 && (potential_y_pos + is_vertical_position * i) <= 10
            b = false
          end
        end
        if b then
          for i in 0..decks_number
            battlefield[potential_x_pos + is_horizontal_position * i][potential_y_pos + is_vertical_position * i] = 1
          end
        end
      end until b
    end
    decks_number -= 1
  end until decks_number == -1
  return battlefield
end


#initialize playground
def init_playground(battlefield)
  playground = Array.new()
  for i in 0..10
    if i == 0
      playground.push([])
      for j in 0..10
        if j == 0
          playground[i].push(92.chr())
        else
          playground[i].push((64+j).chr())
        end
      end
    else
      playground.push([])
      for j in 0..10
        if j == 0
          playground[i].push("#{i}")
        else
          if battlefield[i][j] != 0
            playground[i].push(9617.chr(Encoding::UTF_8)*3)
          else
            playground[i].push(" ")
          end
        end
      end
    end
  end
  return playground
end

#print playground
def print_playground(playground)
  res = 0
  for i in 0..10
    for j in 0..10
        print "#{playground[i][j]}".center(3)
        print "|"
      end
    puts
      44.times do
        print "-"
      end
    puts
  end
end

battlefield = create_ships()
playground = init_playground(battlefield)
print_playground(playground)
