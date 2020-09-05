#属性 => 1 火 2 水 3 木

class Rpg_enemy
  def initialize(hp, hp_max, mp, mp_max, mp_heal, block, atack, speed, zokusei, waza, exp, money)
    @state = {"hp" => hp, "hp_max" => hp_max, "mp" => mp, "mp_max" => mp_max, "mp_heal" => mp_max, "block" => block, "atack" => atack, "speed" => speed, "zokusei" => zokusei, "waza" => waza, "exp" => exp, "money" => money}
  end


  def waza_sel
    srand(Time.now.to_i)
    num = -1
    while num == -1 || @state["waza"][num]["mp"] > @state["mp"]
      num = rand(@state["waza"].size)
    end
    return num
  end

  def heal_mp
    @state["mp"] += @state["mp_heal"]
    @state["mp"] = [@state["mp"], @state["mp_max"]].min
  end

  def state
    @state
  end
end