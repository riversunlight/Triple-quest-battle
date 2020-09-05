class Weapon
  @@head = [
    {"name" => "帽子", "money" => 10, "atack" => 0, "block" => 20, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0,"num" => 0},
    {"name" => "ヘルメット", "money" => 30, "atack" => 0, "block" => 30, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 1},
    {"name" => "火の兜", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 80, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 2},
    {"name" => "伝説の兜", "money" => 300, "atack" => 0, "block" => 130, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 3},
    {"name" => "高専の兜", "money" => 5000, "atack" => 0, "block" => 500, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 4}
  ]

  @@arm = [
    {"name" => "服", "money" => 5, "atack" => 0, "block" => 10, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 0},
    {"name" => "手袋", "money" => 15, "atack" => 0, "block" => 15, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 1},
    {"name" => "水の制服", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 80, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 2},
    {"name" => "伝説の制服", "money" => 150, "atack" => 0, "block" => 75, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 3},
    {"name" => "高専の服", "money" => 1000, "atack" => 0, "block" => 450, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 4}
  ]

  @@sord = [
    {"name" => "棒", "money" => 5, "atack" => 10, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 0},
    {"name" => "木刀", "money" => 20, "atack" => 30, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 1},
    {"name" => "火の剣", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 60, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 2},
    {"name" => "水の剣", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 60, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 3},
    {"name" => "木の剣", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 60, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 4},
    {"name" => "伝説の剣", "money" => 150, "atack" => 75, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 5},
    {"name" => "高専の剣", "money" => 1000, "atack" => 700, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 6}
  ]

  @@seald = [ 
    {"name" => "紙", "money" => 5, "atack" => 0, "block" => 3, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 0},
    {"name" => "段ボール盾", "money" => 20, "atack" => 0, "block" => 30, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 1},
    {"name" => "火の盾", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 30, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 2},
    {"name" => "水の盾", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 30, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 3},
    {"name" => "木の盾", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 30, "p_r" => 0, "a_r" => 0, "num" => 4},
    {"name" => "伝説の盾", "money" => 150, "atack" => 0, "block" => 100, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 5},
    {"name" => "高専の盾", "money" => 1000, "atack" => 0, "block" => 600, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 6}
  ]

  @@armor = [
    {"name" => "見えない鎧", "money" => 5, "atack" => 0, "block" => 1, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 0},
    {"name" => "鉛の鎧", "money" => 500, "atack" => 0, "block" => 30, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 1},
    {"name" => "木の鎧", "money" => 50, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 80, "p_r" => 0, "a_r" => 0, "num" => 2},
    {"name" => "伝説の鎧", "money" => 300, "atack" => 0, "block" => 400, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 3},
    {"name" => "高専の鎧", "money" => 1000, "atack" => 0, "block" => 700, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 4}
  ]

  @@shoes = [
    {"name" => "体育館シューズ", "money" => 20, "atack" => 0, "block" => 0, "speed" => 10, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" =>0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 0},
    {"name" => "人気No.1シューズ", "money" => 30, "atack" => 0, "block" => 0, "speed" => 30, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" =>0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 1},
    {"name" => "固い靴", "money" => 30, "atack" => 0, "block" => 20, "speed" => 20, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" =>0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 2},
    {"name" => "伝説の靴", "money" => 300, "atack" => 0, "block" => 0, "speed" => 80, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" =>0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 3},
    {"name" => "高専の靴", "money" => 1000, "atack" => 0, "block" => 0, "speed" => 100, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" =>0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 4}
  ]

  @@amulet = [
    {"name" => "合格祈願", "money" => 10, "atack" => 0, "block" => 30, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 0},
    {"name" => "安全第一", "money" => 10, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 3, "num" => 1},
    {"name" => "運気上昇", "money" => 20, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 5, "a_r" => 0, "num" => 2},
    {"name" => "火のお守り", "money" => 30, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 10, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 3},
    {"name" => "水のお守り", "money" => 30, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 10, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 4},
    {"name" => "木のお守り", "money" => 30, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 10, "p_r" => 0, "a_r" => 0, "num" => 5},
    {"name" => "伝説のお守り", "money" => 300, "atack" => 0, "block" => 400, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 6},
    {"name" => "高専のお守り", "money" => 1000, "atack" => 0, "block" => 500, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 0, "num" => 7}
  ]

  @@eye = [
    {"name" => "裸眼", "money" => 10, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 1, "a_r" => 0, "num" => 0},
    {"name" => "コンタクト", "money" => 15, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 3, "a_r" => 0, "num" => 1},
    {"name" => "双眼鏡", "money" => 20, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 10, "a_r" => 0, "num" => 2},
    {"name" => "伝説の眼球", "money" => 400, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 20, "a_r" => 0, "num" => 3},
    {"name" => "高専の眼球", "money" => 1000, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 40, "a_r" => 0, "num" => 4}
  ]

  @@ear = [
    {"name" => "ヘッドフォン", "money" => 10, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 1, "num" => 0},
    {"name" => "高級ヘッドセット", "money" => 15, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 3, "num" => 1},
    {"name" => "福耳", "money" => 20, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 10, "num" => 2},
    {"name" => "伝説の耳", "money" => 400, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 20, "num" => 3},
    {"name" => "高専の耳", "money" => 1000, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "p_r" => 0, "a_r" => 40, "num" => 4}
  ]

  def self.buy_wea(sel, num)    
      if Weapon.menu(sel)[num]["money"] <= $player.money
        $player.money = $player.money - Weapon.menu(sel)[num]["money"]
        $player.equi_push(Weapon.sel_to_str(sel), Weapon.menu(sel)[num])
        return 0
      else
        return 1
    end
  end

  def self.can_num(sel)
    case(sel)
    when 0, 1
      if $player.lv <= 4
        return 1
      elsif $player.lv <= 19
        return 2
      elsif $player.lv <= 49
        return 3
      elsif $player.lv <= 98
        return 4
      else
        return 5
      end
    when 2, 3
      if $player.lv <= 4
        return 1
      elsif $player.lv <= 5
        return 2
      elsif $player.lv <= 49
        return 5
      elsif $player.lv <= 79
        return 6
      elsif $player.lv <= 99
        return 7
      end
    when 4
      if $player.lv <= 29
        return 1
      elsif $player.lv <= 49
        return 2
      elsif $player.lv <= 79
        return 3
      elsif $player.lv <= 98
        return 4
      elsif $player.lv <= 99
        return 5
      end
    when 5
      if $player.lv <= 4
        return 1
      elsif $player.lv <= 19
        return 2
      elsif $player.lv <= 79
        return 3
      elsif $player.lv <= 98
        return 4
      elsif $player.lv <= 99
        return 5
      end
    when 6
      if $player.lv <= 9
        return 1
      elsif $player.lv <= 19
        return 2
      elsif $player.lv <= 49
        return 3
      elsif $player.lv <= 79
        return 6
      elsif $player.lv <= 98
        return 7
      elsif $player.lv <= 99
        return 8
      end
    when 7, 8
      if $player.lv <= 19
        return 1
      elsif $player.lv <= 49
        return 2
      elsif $player.lv <= 79
        return 3
      elsif $player.lv <= 98
        return 4
      elsif $player.lv <= 99
        return 5
      end
    end
  end

  def self.menu(sel)
    case(sel)
    when 0
      @@head
    when 1
      @@arm
    when 2
      @@sord
    when 3
      @@seald
    when 4
      @@armor
    when 5
      @@shoes
    when 6
      @@amulet
    when 7
      @@eye
    when 8
      @@ear
    end
  end

  def self.sel_to_str(sel)
    case(sel)
    when 0
      "h_head"
    when 1
      "h_arm"
    when 2
      "h_sord"
    when 3
      "h_seald"
    when 4
      "h_armor"
    when 5
      "h_shoes"
    when 6
      "h_amulet"
    when 7
      "h_eye"
    when 8
      "h_ear"
    end
  end
  def self.sel_equi_to_str(sel)
    case(sel)
    when 0
      "head"
    when 1
      "arm"
    when 2
      "sord"
    when 3
      "seald"
    when 4
      "armor"
    when 5
      "shoes"
    when 6
      "amulet"
    when 7
      "eye"
    when 8
      "ear"
    end
  end
  def self.r_hash
    ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r"]
  end
end