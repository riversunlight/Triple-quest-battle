#属性 1 => 火 2 => 水 3 => 木

class Fighting_enemy
  def initialize(hp, hp_max, speed, atack, jump, block, move, stop, zokusei, exp, money)
    @state = {"hp" => hp, "hp_max" => hp_max, "speed" => speed, "atack" => atack, "jump" => jump, "block" => block, "zokusei" => zokusei, "move" => move, "stop" => stop, "money" => money, "exp" => exp}
    @move_time = 0
    @atack_time = 0
    @der = 0
    @stop_time = 0
    @jump_flag = 0
  end

  def move(x, jump_flag)
    if @state["move"] == 0
      vec = [-1, 1]
      if @move_time == 0
        can_vec = []
        vec.size.times do |i|
          if x + @state["speed"] * vec[i] * 30 >= 75 && x + @state["speed"] * vec[i] * 30 <= 525
            can_vec.push(i)
          end
        end
        @der = can_vec[rand(can_vec.size)]
        @move_time = 30
      else
        x += vec[@der] * @state["speed"]
        @move_time -= 1
      end
      
      if jump_flag == 0
        r = rand(100)
        jump_flag = 1 if r == 1
      else
        srand(Time.now.to_i)
      end

      if @atack_time == 0
        if @stop_time == 0
          r = rand(20)
          if r == 1
            @atack_time = 30
          end
        else
          @stop_time -= 1
        end
      else
        @atack_time -= 1
        @stop_time = @state["stop"]
      end
    end

    return x, jump_flag, @der, @atack_time
  end

  def state
    @state
  end
end