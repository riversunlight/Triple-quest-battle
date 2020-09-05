#属性 1 => 火 2 => 水 3 => 木

class Shooting_enemy
  @@move_time = 0
  @@move_dir = 0
  @@heal_time = 0
  @@shot_time = 0

  def initialize(hp, hp_max, mp, mp_max, mp_heal, atack, speed, block, boal_speed, time, zokusei, move_lv, money, exp)
    @state = {"hp" => hp, "hp_max" => hp_max, "mp" => mp, "mp_max" => mp_max, "mp_heal" => mp_heal, "atack" => atack, "speed" => speed, "block" => block, "boal_speed" => boal_speed, "time" => time, "zokusei" => zokusei, "move_lv" => move_lv, "money" => money, "exp" => exp}
  end

  def move(ex, ey)
    if @@move_time % 30 == 0
      @state["mp"] += @state["mp_heal"]
      @state["mp"] = [@state["mp"], @state["mp_max"]].min
    end

    case(@state["move_lv"])
    when 0
      xvec = [0, 1, 0, -1]
      yvec = [-1, 0, 1, 0]
      if @@move_time % 30 == 0
        cho = []
        4.times do |i|
          if xvec[i] * 30 + ex <= 525 && xvec[i] * 30 + ex >= 0 && yvec[i] * 30 + ey <= 525 && yvec[i] * 30 + ey >= 0
            cho.push(i)
          end
        end
    
        srand(Time.now.to_i)
        @@move_dir = cho[rand(cho.size)]
        @@move_time += 1
        return ex, ey, @@move_dir
      else
        @@move_time += 1
        return ex + xvec[@@move_dir], ey + yvec[@@move_dir], @@move_dir
      end
    end
  end

  def shot(x, y, boal)
    srand(Time.now.to_i)
    r = rand(2)
    if r == 0 && @state["mp"] >= 3 && @@shot_time == 0
      @state["mp"] -= 3
      boal.push([x, y, @@move_dir])
      @@shot_time = @state["time"]
    end

    num = 0
    boal.size.times do |i|
      ch = i - num
      case(boal[ch][2])
      when 0
        boal[ch][1] -= @state["boal_speed"]
      when 1
        boal[ch][0] += @state["boal_speed"]
      when 2
        boal[ch][1] += @state["boal_speed"]
      when 3
        boal[ch][0] -= @state["boal_speed"]
      end

      if boal[ch][0] < -75 || boal[ch][0] > 675 || boal[ch][1] < -75 || boal[ch][1] > 675
        boal.delete_at(i)
        num += 1
      end
    end

    if @@shot_time != 0
      @@shot_time -= 1
    end
    return boal
  end

  def state
    @state
  end
end