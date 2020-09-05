class Shooting
  @@s_f = -1
  @@cx = 5
  @@cy = 490
  @@ex = 500
  @@ey = 65
  @@time = 0
  @@cder = 0
  @@eder = 2
  @@back_ground = Sprite.new(0, 0, Image.new(600, 600, C_GREEN))
  @@boal = []
  @@boal_che = []
  @@e_boal = []
  @@change = 0

  #写真
  @@player_boal = Image.load('image/player_boal.png').set_color_key(C_WHITE)
  @@player_boal_cheice = Image.load('image/player_boal_cheice.png').set_color_key(C_WHITE)
  @@enemy_boal = [
    Image.load('image/enemy_boal0.png').set_color_key(C_WHITE),
    Image.load('image/enemy_boal1.png').set_color_key(C_WHITE),
    Image.load('image/enemy_boal2.png').set_color_key(C_WHITE),
  ]

  def self.ple_move
    if Input.key_push?(K_W) && @@cy >= $player.speed
      @@cy -= $player.speed
      @@cder = 0
    end
    if Input.key_push?(K_A) && @@cx >= $player.speed
      @@cx -= $player.speed
      @@cder = 3
    end
    if Input.key_push?(K_S) && @@cy <= 600 - $player.speed - 75
      @@cy += $player.speed
      @@cder = 2
    end
    if Input.key_push?(K_D) && @@cx <= 600 - $player.speed - 75
      @@cx += $player.speed
      @@cder = 1
    end
    if Input.key_push?(K_J) && $player.b_mp >= 5
      @@boal.push([@@cx, @@cy, @@cder])
      $player.b_mp = $player.b_mp - 5
    end
    if Input.key_push?(K_K) && $player.b_mp >= 7
      @@boal_che.push([@@cx, @@cy, 250])
      $player.b_mp = $player.b_mp - 7
    end
  end


  def self.boal_move
    num = 0
    @@boal.size.times do |i|
      ch = i - num
      case(@@boal[ch][2])
      when 0
        @@boal[ch][1] -= $player.boal_s
      when 1
        @@boal[ch][0] += $player.boal_s
      when 2
        @@boal[ch][1] += $player.boal_s
      when 3
        @@boal[ch][0] -= $player.boal_s
      end

      if @@boal[ch][0] < -75 || @@boal[ch][0] > 675 || @@boal[ch][1] < -75 || @@boal[ch][1] > 675
        @@boal.delete_at(ch)
        num += 1
      end
    end

    num = 0
    @@boal_che.size.times do |i|
      ch = i - num
      if @@boal_che[ch][0] > @@ex
        @@boal_che[ch][0] -= [($player.boal_s / 2).ceil, 1].max
      elsif @@boal_che[ch][0] < @@ex
        @@boal_che[ch][0] += [($player.boal_s / 2).ceil, 1].max
      end
      if @@boal_che[ch][1] > @@ey
        @@boal_che[ch][1] -= [($player.boal_s / 2).ceil, 1].max
      elsif @@boal_che[ch][1] < @@ey
        @@boal_che[ch][1] += [($player.boal_s / 2).ceil, 1].max
      end

      @@boal_che[ch][2] -= 1
      if @@boal_che[ch][2] <= 0
        @@boal_che.delete_at(ch)
        num += 1
      end
    end
  end


  def self.atack(enemy_data, num)
    sum = 0
    case(num)
    when 0
      sum += $player.atack
      case(enemy_data.state["zokusei"])
      when 0
        sum += $player.k_water
      when 1
        sum += $player.k_tree
      when 2
        sum += $player.k_fire
      end

      sum -= enemy_data.state["block"]
      sum = [1, sum].max
      enemy_data.state["hp"] -= sum
      enemy_data.state["hp"] = [enemy_data.state["hp"], 0].max
    when 1
      sum += enemy_data.state["atack"]
      case(enemy_data.state["zokusei"])
      when 0
        sum -= $player.b_water
      when 1
        sum -= $player.b_tree
      when 2
        sum -= $player.b_fire
      end

      sum -= enemy_data.state["block"]
      sum = [1, sum].max
      $player.hp -= sum
      $player.hp = [$player.hp, 0].max
    end
  end


  def self.hit(enemy_data)
    com_spr = Sprite.new(@@cx, @@cy, Image.new(75, 75, C_WHITE))
    enemy_spr = Sprite.new(@@ex, @@ey, Image.new(75, 75, C_WHITE))
    num = 0
    @@boal.size.times do |i|
      ch = i - num
      b_sprite = Sprite.new(@@boal[ch][0], @@boal[ch][1], Image.new(75, 75, C_BLACK))
      if enemy_spr === b_sprite
        Shooting.atack(enemy_data, 0)
        @@boal.delete_at(i)
        num += 1
      end
    end
    @@boal_che.size.times do |i|
      ch = i - num
      b_sprite = Sprite.new(@@boal_che[ch][0], @@boal_che[ch][1], Image.new(75, 75, C_BLACK))
      if enemy_spr === b_sprite
        Shooting.atack(enemy_data, 0)
        @@boal_che.delete_at(i)
        num += 1
      end
    end

    num = 0
    @@e_boal.size.times do |i|
      ch = i - num
      b_sprite = Sprite.new(@@e_boal[ch][0], @@e_boal[ch][1], Image.new(75, 75, C_BLACK))
      if com_spr === b_sprite
        Shooting.atack(enemy_data, 1)
        @@e_boal.delete_at(i)
        num += 1
      end
    end
  end

  def self.die?(enemy_data, num)
    if num == 0
      #自分が生きているか
      if $player.hp <= 0
        return true
      else
        return false
      end
    else
      #敵が生きているか
      if enemy_data.state["hp"] <= 0
        return true
      else
        return false
      end
    end
  end

  def self.wait(enemy_data)
    if Op_update.AnyKey_push? || Input.key_push?(K_RETURN)
      case(@@s_f)
      when 1
        @@s_f = 0
      when 2
        @@s_f = 3
      when 3
        @@change = 3
      when 4
        @@s_f = 5
        $player.exp = $player.exp + enemy_data.state["exp"]
        $player.g_exp = $player.g_exp + enemy_data.state["exp"]
        $player.g_money = $player.g_money + enemy_data.state["money"]
        $player.k_monster = $player.k_monster + 1
      when 5
        if $player.lv_up?
          @@s_f = 6
        else
          @@change = 2
        end
      when 6
        @@change = 2
      end
    end
  end
  
  
  def self.move(enemy_data)
    case(@@s_f)
    when 0
      Shooting.ple_move
      Shooting.boal_move
      Shooting.hit(enemy_data)
      @@e_boal = enemy_data.shot(@@ex, @@ey, @@e_boal)
      @@ex, @@ey, @@eder = enemy_data.move(@@ex, @@ey)
      $player.b_mp_heal
      if Shooting.die?(enemy_data, 0) 
        @@s_f = 2
      end
      if Shooting.die?(enemy_data, 1) 
        @@s_f = 4
      end
    when 1, 2, 3, 4, 5, 6
      Shooting.wait(enemy_data)
    end
  end
  
  
  def self.draw(enemy_name, enemy_image, enemy_data)
    Shooting.move(enemy_data)
    Sprite.draw([@@back_ground])
        
    #自機の表示
    @@image = 0
    case($player.skin)
    when 0
      @@image = Image.load("image/yuusya#{@@cder}.png")
      @@image.set_color_key(C_WHITE)
    when 1
      @@image = Image.load("image/tako#{@@cder}.png")
      @@image.set_color_key(C_WHITE)
    when 2
      @@image = Image.load("image/ika#{@@cder}.png")
      @@image.set_color_key(C_RED)
    end
    Window.draw(@@cx, @@cy, @@image)
    if !Shooting.die?(enemy_data, 1)
      Window.draw(@@ex, @@ey, enemy_image[@@eder])
      @@e_boal.size.times do |i|
        Window.draw(@@e_boal[i][0], @@e_boal[i][1], @@enemy_boal[enemy_data.state["zokusei"] - 1])
      end
    end
    @@boal.size.times do |i|
      Window.draw(@@boal[i][0], @@boal[i][1], @@player_boal)
    end
    @@boal_che.size.times do |i|
      Window.draw(@@boal_che[i][0], @@boal_che[i][1], @@player_boal_cheice)
    end

    case(@@s_f)
    when -1
      @@board1 = Sprite.new(0, 0, Image.new(600, 300 - @@time, C_BLACK))
      @@board2 = Sprite.new(0, 300 + @@time, Image.new(600, 300 - @@time, C_BLACK))
      @@time += 10
      Sprite.draw([@@board1, @@board2])
  
      if @@time >= 300
        @@s_f = 1
      end
    when 0
      #ステータスの表示ヨロ
      @@h_b = Sprite.new(5, 564, Image.new(364, 34, C_WHITE))
      @@b_b = Sprite.new(7, 566, Image.new(360, 30, C_BLACK))
      Sprite.draw([@@h_b, @@b_b])
      Window.draw_font(7, 566, "#{$player.name} HP:#{$player.hp}/#{$player.hp_max} MP:#{$player.b_mp}/#{$player.b_mp_max}", $font_30)
      
      @@h_b = Sprite.new(300, 5, Image.new(274, 64, C_WHITE))
      @@b_b = Sprite.new(302, 7, Image.new(270, 60, C_BLACK))
      Sprite.draw([@@h_b, @@b_b])
      Window.draw_font(302, 7, "#{enemy_name}", $font_30)
      Window.draw_font(302, 37, "HP:#{enemy_data.state["hp"]}/#{enemy_data.state["hp_max"]}", $font_30)

      case(enemy_data.state["zokusei"])
      when 1
        Window.draw_font(542, 7, "火", $font_30)
      when 2
        Window.draw_font(542, 7, "水", $font_30)
      when 3
        Window.draw_font(542, 7, "木", $font_30)
      end
    when 1, 2, 3, 4, 5, 6
      @@h_b1 = Sprite.new(5, 350, Image.new(590, 245, C_WHITE))
      @@b_b1 = Sprite.new(7, 352, Image.new(586, 241, C_BLACK))
      Sprite.draw([@@h_b1, @@b_b1])
      
      #コメント
      case(@@s_f)
      when 1
        Window.draw_font(7, 352, "#{enemy_name}が現れた", $font_30)
      when 2
        Window.draw_font(7, 352, "#{$player.name}は倒れた", $font_30)
      when 4
        Window.draw_font(7, 352, "#{enemy_name}は倒れた", $font_30)
      when 5
        Window.draw_font(7, 352, "お金: #{enemy_data.state["money"]} 経験値: #{enemy_data.state["exp"]}　獲得", $font_30)
      when 6
        Window.draw_font(7, 352, "#{$player.name}はレベルが上がった!!!", $font_30)
      end
    end

    if @@change != 0
      num = @@change
      @@change = 0
      @@boal = []
      @@boal_che = []
      @@e_boal = []
      @@s_f = -1
      @@cx = 5
      @@cy = 490
      @@ex = 500
      @@ey = 65
      @@time = 0
      @@cder = 0
      @@eder = 2
      $player.b_mp = $player.state["b_mp_max"]
      return num, enemy_data
    end
    return 0, enemy_data
  end
end