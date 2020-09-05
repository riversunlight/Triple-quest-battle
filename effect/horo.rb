class Horo
  @@menu = [
    {"name" => "手相占い", "money" => 5},
    {"name" => "水晶占い", "money" => 30},
    {"name" => "高専占い", "money" => 50}
  ]
  @@effect = [  
    {"msg_size" => 1, "msg0" => "あなた様には、力の神が舞い降りております", "heal" => 0, "atack" => 10, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0,"k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、守りの神が舞い降りております", "heal" => 0, "atack" => 0, "block" => 10, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、速さの神が舞い降りております", "heal" => 0, "atack" => 10, "block" => 0, "speed" => 10, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 2, "msg0" => "これはこれは", "msg1" => "あなた様には、命の神が舞い降りております", "heal" => 10, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 2, "msg0" => "これはこれは", "msg1" => "残念ながら,あなた様には、命とりがとりついております", "heal" => -5, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、火の神が舞い降りております", "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 20, "k_water" => 0, "k_tree" => 0, "b_fire" => 20, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、水の神が舞い降りております", "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 20, "k_tree" => 0, "b_fire" => 0, "b_water" => 20, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、木の神が舞い降りております", "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 20, "b_fire" => 0, "b_water" => 0, "b_tree" => 20, "all" => 0},
    {"msg_size" => 2, "msg0" => "おーめでたい", "msg1" => "あなた様には、強力な神が舞い降りております", "heal" => 0, "atack" => 40, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 2, "msg0" => "なんと不幸な", "msg1" => "あなた様には、力とりがとりついております", "heal" => 0, "atack" => -40, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、命の創造神が舞い降りております", "heal" => 100, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、剛力の神が舞い降りております", "heal" => 0, "atack" => 100, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、守護神が舞い降りております", "heal" => 0, "atack" => 0, "block" => 100, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 1, "msg0" => "あなた様には、不幸にも足枷野郎がとりついております", "heal" => 0, "atack" => 0, "block" => 0, "speed" => -100, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 0},
    {"msg_size" => 3, "msg0" => "こ、こ、これは", "msg1" => "あなた様には、あの化け物どもにも通用する力を持たれた、", "msg2" =>"伝説の神が舞い降りております", "heal" => 0, "atack" => 0, "block" => 0, "speed" => 0, "k_fire" => 0, "k_water" => 0, "k_tree" => 0, "b_fire" => 0, "b_water" => 0, "b_tree" => 0, "all" => 200}
  ]

  def self.horo(num)
    if $player.money < @@menu[num]["money"]
      return -1
    end
    $player.money  = $player.money - @@menu[num]["money"]

    srand(Time.now.to_i)
    r = rand(100)
    sel = 0

    case(num)
    when 0
      if r <= 19
        sel = 0
      elsif r <= 39
        sel = 1
      elsif r <= 59
        sel = 2
      elsif r <= 79
        sel = 3
      elsif r <= 99
        sel = 4
      end
    when 1
      if r <= 29
        sel = 5
      elsif r <= 59
        sel = 6
      elsif r <= 89
        sel = 7
      elsif r <= 94
        sel = 8
      elsif r <= 99
        sel = 9
      end
    when 2
      if r <= 29
        sel = 10
      elsif r <= 59
        sel = 11
      elsif r <= 89
        sel = 12
      elsif r <= 98
        sel = 13
      elsif r <= 99
        sel = 14
      end
    end
    
    Horo.up_st(sel)

    return sel
  end

  def self.up_st(num)
    if $player.hp + @@effect[num]["heal"] <= $player.hp_max
      $player.hp = $player.hp + @@effect[num]["heal"]
    else
      $player.hp = $player.hp_max
    end

    str = ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree"]
    str.size.times do |i|
      $player.effect_add(str[i], @@effect[num][str[i]] + @@effect[num]["all"])
    end
  end
  
  def self.can_num
    if $player.lv <= 29
      return 1
    elsif $player.lv <= 80
      return 2
    else
      return 3
    end
  end

  def self.menu
    @@menu
  end
  def self.effect
    @@effect
  end
end