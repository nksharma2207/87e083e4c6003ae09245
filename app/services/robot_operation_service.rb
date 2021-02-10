class RobotOperationService
  DIRECTIONS = ['EAST', 'SOUTH', 'WEST', 'NORTH']
  DIRECTIONS_MAPPING = {'EAST' => 0, 'SOUTH' => 1, 'WEST' => 2, 'NORTH' => 3}

  def perform(operations)
    @position = {}

    operations.each do |op|
      break if op == 'REPORT'

      place_robot(op.split(' ')[1]) if op.starts_with? 'PLACE'
      if @position[x].present? && @position[y].present? && @position[direction].present?
        move_robot if op == 'MOVE'
        set_robot_direction(op) if DIRECTIONS.include? op
      end
    end
    @position
  end

  private

  def place_robot(new_pos)
    new_pos_array = new_pos.split(',')
    x = new_pos_array[0].to_i
    y = new_pos_array[1].to_i
    direction = new_pos_array[2]
    if (x >= 0) && (y >= 0) && DIRECTIONS.include? direction
      @position = {x: x, y: y, direction: direction}
    end
  end

  def move_robot
    @position[x]+= 1 if @position[direction] == 'EAST'
    @position[y]+= 1 if @position[direction] == 'NORTH'
    @position[x]-= 1 if (@position[direction] == 'WEST') && @position[x] > 0
    @position[y]-= 1 if (@position[direction] == 'SOUTH') && @position[y] > 0
  end

  def set_robot_direction(operation)
    current_direction = @position[direction]
    if current_direction.present?
      current_direction_position = DIRECTIONS_MAPPING[current_direction]
      new_direction_position = current_direction_position + 1 if operation == 'RIGHT'
      new_direction_position = current_direction_position - 1 if operation == 'LEFT'
      @position[direction] = DIRECTIONS[new_direction_position % 4]
    end
  end
end
