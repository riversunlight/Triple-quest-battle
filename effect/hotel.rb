class Hotel
  @@menu = [
    {"name" => "一泊二日    ", "money" => 10, "heal" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "火の眠り    ", "money" => 20, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 10, "k_water" => 0, "k_tree" => 0, "b_fire" => 10, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "水の眠り    ", "money" => 20, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 10, "k_tree" => 0, "b_fire" => 0, "b_water" => 10, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "木の眠り    ", "money" => 20, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 10, "b_fire" => 0, "b_water" => 0, "b_tree" => 10, "p_r" => 0, "a_r" => 0},
    {"name" => "二泊三日    ", "money" => 15, "heal" => 100, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "力の眠り    ", "money" => 60, "heal" => 30, "atack" => 30, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "守りの眠り  ", "money" => 60, "heal" => 60, "atack" => 0, "block" => 20, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "速さの眠り  ", "money" => 60, "heal" => 10, "atack" => 0, "block" => 0, "speed" => 30, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "捨て身の眠り", "money" => 100, "heal" => -10, "atack" => 80, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "永久滞在    ", "money" => 200, "heal" => 1000000000, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "炎の眠り    ", "money" => 150, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 80, "k_water" => 0, "k_tree" => 0, "b_fire" => 80, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "氷の眠り    ", "money" => 150, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 80, "k_tree" => 0, "b_fire" => 0, "b_water" => 80, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "森の眠り    ", "money" => 150, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 80, "b_fire" => 0, "b_water" => 0, "b_tree" => 80, "p_r" => 0, "a_r" => 0},
    {"name" => "覚醒の眠り  ", "money" => 300, "heal" => 100, "atack" =>100, "block" => 100, "speed" => 100, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0},
    {"name" => "眼ほぐし    ", "money" => 500, "heal" => 200, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 40, "a_r" => 0},
    {"name" => "耳ほぐし    ", "money" => 500, "heal" => 200, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 40},
    {"name" => "天才の眠り　", "money" => 1000, "heal" => 100, "atack" => 100, "block" => 100, "speed" => 100, "k_fire" => 100, "k_water" => 100, "k_tree" => 100, "b_fire" => 100, "b_water" => 100, "b_tree" => 100, "p_r" => 0, "a_r" => 0}
  ]

  def self.can_num
    if $player.lv <= 4
      return 4
    elsif $player.lv <= 9
      return 8
    elsif $player.lv <= 29
      return 9
    elsif $player.lv <= 49
      return 13
    elsif $player.lv <= 74
      return 14
    elsif $player.lv <= 98
      return 16
    else
      return 17
    end
  end

  def self.menu
    @@menu
  end

  def self.stay(num)
    if $player.money >= Hotel.menu[num]["money"]
      $player.money = $player.money - Hotel.menu[num]["money"]
      if $player.hp + Hotel.menu[num]["heal"] <= $player.hp_max
        $player.hp = $player.hp + Hotel.menu[num]["heal"]
      else
        $player.hp = $player.hp_max
      end

      str = ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r"]
      str.size.times do |i|
        $player.effect_add(str[i], $player.effect[str[i]] + Hotel.menu[num][str[i]])
      end
      return 0
    else
      return -1
    end
  end
end