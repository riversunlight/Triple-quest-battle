#モード 0 => 全体 1 => 戦闘時使用 2 => 技

class Item
  @@item = [
    {"name" => "薬草", "mode" => 0, "money" => 20, "heal" => 5, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 0},
    {"name" => "爆竹", "mode" => 0, "money" => 10, "heal" => 0, "atack" => 30, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 1},
    {"name" => "食べる鎧", "mode" => 0, "money" => 10, "heal" => 0, "atack" => 0, "block" => 10, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 2},
    {"name" => "俊足シューズ", "mode" => 0, "money" => 10, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 3, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 3},
    {"name" => "爆弾", "mode" => 1, "money" => 30, "damage" => 30, "num" => 4},
    {"name" => "力の書", "mode" => 2, "money" => 5, "waza_size" => 1, "waza0" => "十連突き", "num" => 5},
    {"name" => "魔法の書", "mode" => 2, "money" => 5, "waza_size" => 3, "waza0" => "ファイヤーボール", "waza1" => "ウォーターボール", "waza2" =>  "ツリーボール", "num" => 6},
    {"name" => "ドーピング薬", "mode" => 0, "money" => 30, "heal" => 0, "atack" => 20, "block" => 10, "speed" => 20, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 7},
    {"name" => "集中～火～", "mode" => 0, "money" => 30, "expr" => "水,木のキラーと耐性\nを0にし、減らした分\nの倍火のキラーと\n耐性を増やす", "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => $player.k_water * 2 + $player.k_tree * 2, "k_water" => $player.k_water * (-1), "k_tree" => $player.k_tree, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 8},
    {"name" => "集中～水～", "mode" => 0, "money" => 30, "expr" => "火,木のキラーと耐性\nを0にし、減らした分\nの倍水のキラーと\n耐性を増やす", "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => $player.k_fire * (-1), "k_water" => $player.k_fire * 2 + $player.k_tree * 2, "k_tree" => $player.k_tree * (-1), "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 9},
    {"name" => "集中～木～", "mode" => 0, "money" => 30, "expr" => "火,水のキラーと耐性\nを0にし、減らした分\nの倍木のキラーと\n耐性を増やす", "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => $player.k_fire * (-1), "k_water" => $player.k_water * (-1), "k_tree" => $player.k_fire * 2 + $player.k_tree * 2, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 10},
    {"name" => "魔法の書~改~", "mode" => 2, "money" => 30, "waza_size" => 3, "waza0" => "バーニング", "waza1" => "トルネード", "waza2" => "リーフプライ", "num" => 11},
    {"name" => "ボール(物理)", "mode" => 1, "money" => 50, "damage" => 60, "num" => 12},
    {"name" => "食べる甲冑", "mode" => 0, "money" => 50, "heal" => 0, "atack" => 0, "block" => 40, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 13},
    {"name" => "食べる靴", "mode" => 0, "money" => 50, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 40, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 14},
    {"name" => "力の書~改~", "mode" => 2, "money" => 50, "waza_size" => 1, "waza0" => "たたく(冷蔵庫で)", "num" => 15},
    {"name" => "果物盛り合わせ", "mode" => 0, "money" => 100, "heal" => 500, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 16},
    {"name" => "ローラースケート", "mode" => 0, "money" => 80, "heal" => 0, "atack" => 0, "block" => 0, "speed" => 300, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 17},
    {"name" => "筋トレ", "mode" => 0, "money" => 80, "heal" => 0, "atack" => 150, "block" => 150, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "num" => 18},
    {"name" => "学生証", "mode" => 0, "money" => 1000, "heal" => 150, "atack" => 150, "block" => 150, "speed" => 150, "k_fire" => 150, "k_water" => 150, "k_tree" => 150, "b_fire" => 150, "b_water" => 150, "b_tree" => 150, "num" => 19}
  ]

  def self.buy_item(num)
    if $player.money < @@item[num]["money"]
      return 1
    end

    $player.money = $player.money - @@item[num]["money"]
    $player.item_add(@@item[num]["num"])

    return 0
  end
  

  def self.use_item_park(num)
    if @@item[num]["mode"] == 1
      return 1
    elsif @@item[num]["mode"] == 0
      $player.hp = $player.hp + @@item[num]["heal"]
      $player.hp = [$player.hp_max, $player.hp].min
      str = ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree"]
      str.size do |i|
        $player.effect_add(str[i], @@item[num][str[i]] + $player.effect[str[i]])
      end
    else
      @@item[num]["waza_size"].times do |i|
        $player.waza_push(create_waza(@@item[num]["waza#{i}"]))
      end
    end

    return 0
  end

  def self.create_waza(name)
    waza = 0
    case(name)
    when "十連突き"
      waza = {"name" => "十連突き", "mp" => 3, "atack" => 5, "speed" => 5, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "num" => 1}
    when "ファイヤーボール"
      waza = {"name" => "ファイヤーボール", "mp" => 2, "atack" => 0, "speed" => 3, "k_fire" => 0, "k_water" => 0, "k_tree" => 4, "num" => 2}
    when "ウォーターボール"
      waza = {"name" => "ウォーターボール", "mp" => 2, "atack" => 0, "speed" => 6, "k_fire" => 4, "k_water" => 0, "k_tree" => 0, "num" => 3}
    when "ツリーボール"
      waza = {"name" => "ツリーボール", "mp" => 2, "atack" => 0, "speed" => 3, "k_fire" => 0, "k_water" => 4, "k_tree" => 0, "num" => 4}
    when "バーニング"
      waza = {"name" => "バーニング", "mp" => 5, "atack" => 0, "speed" => 4, "k_fire" => 0, "k_water" => 0, "k_tree" => 10, "num" => 5}
    when "トルネード"
      waza = {"name" => "トルネード", "mp" => 5, "atack" => 0, "speed" => 4, "k_fire" => 20, "k_water" => 0, "k_tree" => 0, "num" => 6}
    when "リーフプライ"
      waza = {"name" => "リーフプライ", "mp" => 5, "atack" => 0, "speed" => 6, "k_fire" => 0, "k_water" => 20, "k_tree" => 0, "num" => 7}
    when "たたく(冷蔵庫で)"
      waza = {"name" => "たたく(冷蔵庫で)", "mp" => 10, "atack" => 30, "speed" => 15, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "num" => 8}
    end

    return waza
  end


  def self.can_num
    if $player.lv <= 4
      return 7
    elsif $player.lv <= 29
      return 12
    elsif $player.lv <=49
      return 16
    elsif $player.lv <= 79
      return 19
    else
      return 20
    end
  end


  def self.menu
    @@item
  end
end