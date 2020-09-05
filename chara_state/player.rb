class Player
  def initialize
    @name = ""
    @lv = 1
    @skin = 0
    @skip = 0
    @b_time = 0
    @check_skin = 0
    @check_skip = 0

    #全体のステータス
    @state = {
      "money" => 0,
      "hp_max" => 20,
      "hp" => 20,
      "atack" => 3,
      "speed" => 5,
      "block" => 0,
      "k_fire" => 0,
      "k_water" => 0,
      "k_tree" => 0,
      "b_fire" => 0,
      "b_water" => 0,
      "b_tree" => 0,
      "p_r" => 3,
      "a_r" => 3,

      #RPG用
      "r_mp_max" => 0,
      "r_mp" => 0,
      "r_mp_heal" => 0,
      "waza" => [
        {"name" => "たたく(素手で)", "mp" => 0, "atack" => 3, "speed" => 10, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "num" => 0}
      ],

      #シューティング用
      "boal_s" => 1,
      "b_mp_max" => 10,
      "b_mp" => 10,
      "b_mp_heal" => 1,

      #格闘用
      "jump" => 0,
      "stop" => 150,

      #持ち物
      "item" => [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      ],
      "exp" => 0,
      
      #取得したもの
      "g_money" => 0,
      "g_exp" => 0,
      "k_monster" => 0
    }

    @equi = {
      "head" => 0,
      "arm" => 0,
      "sord" => 0,
      "seald" => 0,
      "armor" => 0,
      "shoes" => 0,
      "amulet" => 0,
      "eye" => 0,
      "ear" => 0,

      "h_head" => [],
      "h_arm" => [],
      "h_sord" => [],
      "h_seald" => [],
      "h_armor" => [],
      "h_shoes" => [],
      "h_amulet" =>[],
      "h_eye" => [],
      "h_ear" => []
    }

    @effect = {
      "atack" => 0,
      "block" => 0,
      "speed" => 0,
      "k_fire" => 0,
      "k_water" => 0,
      "k_tree" => 0,
      "b_fire" => 0,
      "b_water" => 0,
      "b_tree" => 0,
      "p_r" => 0,
      "a_r" => 0
    }

    @result = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  end

  def lv_up    
    @state["hp_max"] += 3
    @state["atack"] += 3
    @state["speed"] += (@lv % 3 == 0) ? 1 : 0
    @state["block"] += 2
    @state["r_mp_max"] += 3
    @state["r_mp_heal"] += 2
    @state["boal_s"] += 1
    @state["b_mp_max"] += 2
    @state["jump"] += 1
    @state["r_mp"] = @state["r_mp_max"]
    @state["b_mp"] = @state["b_mp_max"]
    @state["hp"] = @state["hp_max"]
    @exp = 0
    @lv += 1
  end

  def lv_up?
    if $player.lv <= 98 && $player.exp >= $player.lv * (10 + ($player.lv / 10) * 5)
      $player.exp = $player.exp - $player.lv * (10 + ($player.lv / 10) * 5)
      $player.lv_up
      return true
    else
      return false
    end
  end
  def name=(name)
    @name = name
  end
  def name
    @name
  end
  def lv
    @lv
  end
  def lv=(lv)
    @lv = lv
  end
  def money
    @state["money"]
  end
  def money=(money)
    @state["money"] = money
  end
  def g_money
    @state["g_money"]
  end
  def g_money=(g_money)
    @state["g_money"] = g_money
  end
  def skin=(skin)
    @skin = skin
    @check_skin = 1
  end
  def skip=(skip)
    @skip = skip
    @check_skip = 1
  end
  def skin
    @skin
  end
  def skip
    @skip
  end
  def check_skin
    @check_skin
  end
  def check_skip
    @check_skip
  end
  def state
    @state
  end
  def hp
    @state["hp"]
  end
  def hp=(hp)
    @state["hp"] = hp
  end
  def hp_max
    @state["hp_max"]
  end
  def hp_max=(hp_max)
    @state["hp_max"] = hp_max
  end
  def atack
    sum = @state["atack"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["atack"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["atack"]
    sum = [sum, 1].max
    return sum
  end
  def atack_base
    @state["atack"]
  end
  def atack=(atack)
    @state["atack"] = atack
  end
  def speed
    sum = @state["speed"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["speed"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["speed"]
    sum = [sum, 1].max
    return sum
  end
  def speed_base
    @state["speed"]
  end
  def speed=(speed)
    @state["speed"] = speed
  end
  def block
    sum = @state["block"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["block"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["block"]
    sum = [sum, 0].max
    return sum
  end
  def block_base
    @state["block"]
  end
  def block=(block)
    @state["block"] = block
  end
  def k_fire
    sum = @state["k_fire"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["k_fire"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["k_fire"]
    sum = [sum, 0].max
    return sum
  end
  def k_fire_base
    @state["k_fire"]
  end
  def k_fire=(k_fire)
    @state["k_fire"] = k_fire
  end
  def k_water
    sum = @state["k_water"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["k_water"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["k_water"]
    sum = [sum, 0].max
    return sum
  end
  def k_water_base
    @state["k_water"]
  end
  def k_water=(k_water)
    @state["k_water"] = k_water
  end
  def k_tree
    sum = @state["k_tree"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["k_tree"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["k_tree"]
    sum = [sum, 0].max
    return sum
  end
  def k_tree_base
    @state["k_tree"]
  end
  def k_tree=(k_tree)
    @state["k_tree"] = k_tree
  end
  def b_fire
    sum = @state["b_fire"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["b_fire"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["b_fire"]
    su, = [sum, 0].max
    return sum
  end
  def b_fire_base
    @state["b_fire"]
  end
  def b_fire=(b_fire)
    @state["b_fire"] = b_fire
  end
  def b_water
    sum = @state["b_water"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["b_water"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["b_water"]
    sum = [sum, 0].max
    return sum
  end
  def b_water_base
    @state["b_water"]
  end
  def b_water=(b_water)
    @state["b_water"] = b_water
  end
  def b_tree
    sum = @state["b_tree"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["b_tree"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["b_tree"]
    sum = [sum, 0].max
    return sum
  end
  def b_tree_base
    @state["b_tree"]
  end
  def b_tree=(b_tree)
    @state["b_tree"] = b_tree
  end
  def r_mp
    @state["r_mp"]
  end
  def r_mp=(r_mp)
    @state["r_mp"] = r_mp
  end
  def r_mp_max
    @state["r_mp_max"]
  end
  def r_mp_max=(r_mp_max)
    @state["r_mp_max"] = r_mp_max
  end
  def r_mp_heal
    @state["r_mp_heal"]
  end
  def r_mp_heal=(num)
    @state["r_mp_heal"] = num
  end
  def waza
    @state["waza"]
  end
  def waza_push(waza)
    @state["waza"].push(waza)
    @state["waza"].sort_by!{|i| i["num"]}
    @state["waza"].uniq!
  end
  def boal_s
    @state["boal_s"]
  end
  def boal_s=(boal_s)
    @state["boal_s"] = boal_s
  end
  def b_mp
    @state["b_mp"]
  end
  def b_mp=(b_mp)
    @state["b_mp"] = b_mp
  end
  def b_mp_max
    @state["b_mp_max"]
  end
  def b_mp_max=(b_mp_max)
    @state["b_mp_max"] = b_mp_max
  end
  def b_mp_heal
    @state["b_mp_heal"]
  end
  def b_mp_heal=(num)
    @state["b_mp_heal"] = num
  end
  def jump
    @state["jump"]
  end
  def jump=(jump)
    @state["jump"] = jump
  end
  def stop
    @state["stop"]
  end
  def stop=(stop)
    @state["stop"] = stop
  end
  def item
    @state["item"]
  end
  def item_add(num)
    @state["item"][num] += 1
  end
  def item_take(num)
    @state["item"][num] -= 1
  end
  def effect
    @effect
  end
  def effect_add(sel, num)
    @effect[sel] = num
  end
  def effect_reset
    str = ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree"]
    str.size.times do |i|
      @effect[str[i]] = 0
    end
  end
  def p_r
    sum = @state["p_r"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["p_r"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["p_r"]
    return sum
  end
  def p_r_base
    @state["p_r"]
  end
  def p_r=(p_r)
    @state["p_r"] = p_r
  end
  def a_r
    sum = @state["a_r"]
    9.times do |i|
      sum += $player.equi[Weapon.sel_equi_to_str(i)]["a_r"] if $player.equi[Weapon.sel_equi_to_str(i)] != 0
    end
    sum += @effect["a_r"]
    return sum
  end
  def a_r_base
    @state["a_r"]
  end
  def a_r=(a_r)
    @state["a_r"] = a_r
  end
  def equi
    @equi
  end
  def equi_push(part, equi)
    @equi[part].push(equi)
  end
  def equi_set(part, obj)
    @equi[part] = obj
  end
  def exp
    @state["exp"]
  end
  def exp=(exp)
    @state["exp"] = exp
  end
  def g_exp
    @state["g_exp"]
  end
  def g_exp=(g_exp)
    @state["g_exp"] = g_exp
  end
  def k_monster
    @state["k_monster"]
  end
  def k_monster=(k_monster)
    @state["k_monster"] = k_monster
  end
  def time_reset
    @b_time = 0
  end
  def heal_mp
    @state["r_mp"] += @state["r_mp_heal"]
    @state["r_mp"] = [@state["r_mp"], @state["r_mp_max"]].min
  end
  def b_mp_heal
    if @b_time % 30 == 0
      @state["b_mp"] += @state["b_mp_heal"]
      @state["b_mp"] = [@state["b_mp"], @state["b_mp_max"]].min
    end
    @b_time += 1
  end
  def result
    @result
  end
  def result_add(num)
    @result[num] += 1
  end
  def result_add2(n1, n2)
    @result[n1] = n2
  end
  def erase_en
    @name.chomp!
  end
  def create_waza(num)
    waza = 0
    case(num)
    when 1
      waza = {"name" => "十連突き", "mp" => 3, "atack" => 5, "speed" => 5, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "num" => 1}
    when 2
      waza = {"name" => "ファイヤーボール", "mp" => 2, "atack" => 0, "speed" => 3, "k_fire" => 0, "k_water" => 0, "k_tree" => 4, "num" => 2}
    when 3
      waza = {"name" => "ウォーターボール", "mp" => 2, "atack" => 0, "speed" => 6, "k_fire" => 4, "k_water" => 0, "k_tree" => 0, "num" => 3}
    when 4
      waza = {"name" => "ツリーボール", "mp" => 2, "atack" => 0, "speed" => 3, "k_fire" => 0, "k_water" => 4, "k_tree" => 0, "num" => 4}
    when 5
      waza = {"name" => "バーニング", "mp" => 5, "atack" => 0, "speed" => 4, "k_fire" => 0, "k_water" => 0, "k_tree" => 10, "num" => 5}
    when 6
      waza = {"name" => "トルネード", "mp" => 5, "atack" => 0, "speed" => 4, "k_fire" => 20, "k_water" => 0, "k_tree" => 0, "num" => 6}
    when 7
      waza = {"name" => "リーフプライ", "mp" => 5, "atack" => 0, "speed" => 6, "k_fire" => 0, "k_water" => 20, "k_tree" => 0, "num" => 7}
    when 8
      waza = {"name" => "たたく(冷蔵庫で)", "mp" => 10, "atack" => 30, "speed" => 15, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "num" => 8}
    end
    return waza
  end
end