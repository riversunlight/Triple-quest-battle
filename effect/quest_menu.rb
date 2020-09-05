class Quest_menu
  @@menu = [
    "初めてのクエスト",
    "荒れ噴くマグマ",
    "冷徹な海",
    "猛獣の森",
    "伝統的な魔王討伐",
    "弾打ち合戦",
    "キック&パンチ",
    "蔓延する病原体",
    "課題の大襲来~迫りくる締め切り~",
    "擬人化プログラミング言語",
    "化け物高専生の教室"
  ]

  def self.can_num
    if $player.lv <= 1
      return 1
    elsif $player.lv <= 20
      return 4
    elsif $player.lv <= 50
      return 7
    elsif $player.lv <= 70
      return 8
    elsif $player.lv <= 80
      return 9
    elsif $player.lv <= 98
      return 10
    elsif $player.lv <= 99
      return 11
    end
  end

  def self.menu
    @@menu
  end
end