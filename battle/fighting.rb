class Fighting
  @@cx = 100
  @@cy = 300
  @@cder = 4
  @@ca = 0
  @@ex = 500
  @@ey = 300
  @@eder = 0
  @@ea = 0
  @@s_f = -1
  @@time = 0
  @@jump_time = 0
  @@jump_flag = 0
  @@e_jump_flag = 0
  @@e_jump_time = 0
  @@e_atack_time = 0
  @@e_atack_flag = 0
  @@v = 0
  @@ev = 0
  @@one_atack = 0
  @@change = 0
  @@back_ground = Sprite.new(0, 0, Image.new(600, 600, C_GREEN))
  @@back_ground2 = Sprite.new(0, 400, Image.new(600, 200, C_BLACK))

  def self.ple_move
    if Input.key_push?(K_A) && @@cx - $player.speed >= 0
      @@cx -= $player.speed
      @@cder = 5
    end
    if Input.key_push?(K_D) && @@cx + $player.speed <= 525
      @@cx += $player.speed
      @@cder = 4
    end
    if (Input.key_push?(K_W) || Input.key_push?(K_SPACE)) && @@cy == 300
      @@jump_time = 0
      @@v = $player.jump + 10
      @@jump_flag = 1
    end
    if Input.key_push?(K_J) && @@time == 0
      @@ca = 1
      @@one_atack = 1
      @@time = $player.stop
    end
  end


  def self.jump(num, enemy_data)
    if num == 0
      @@cy -= @@v
      @@v -= 1
      if @@cy > 300
        @@cy = 300
        @@jump_flag = 0
      end
    else
      @@ey -= @@ev
      @@ev -= 1
      if @@ey > 300
        @@ey = 300
        @@e_jump_flag = 0
      end
    end
  end


  def self.die?(enemy_data, num)
    if num == 0
      if $player.hp <= 0
        return true
      else
        return false
      end
    else
      if enemy_data.state["hp"] <= 0
        return true
      else
        return false
      end
    end
  end


  def self.atack(enemy_data, num)
    if num == 0
      sum = 0
      sum += $player.atack
      case(enemy_data.state["zokusei"])
      when 0
        sum += $player.k_fire
      when 1
        sum += $player.k_water
      when 2
        sum += $player.k_tree
      end

      sum -= enemy_data.state["block"]
      sum = [1, sum].max
      enemy_data.state["hp"] -= sum
      enemy_data.state["hp"] = [0, enemy_data.state["hp"]].max
    else
      sum = 0
      sum += enemy_data.state["atack"]
      case(enemy_data.state["zokusei"])
      when 0
        sum -= $player.b_fire
      when 1
        sum += $player.b_water
      when 2
        sum += $player.b_tree
      end

      sum -= $player.state["block"]
      sum = [1, sum].max
      $player.state["hp"] -= sum
      $player.state["hp"] = [0, $player.state["hp"]].max
    end
  end


  def self.hit(enemy_data, num)
    if num == 0
      if @@time >= 1
        @@time -= 1
        enemy = Sprite.new(@@ex + 10, @@ey + 5, Image.new(65, 70, C_BLACK))
        atack_range = Sprite.new(@@cx + 45, @@cy + 20, Image.new(20, 25, C_WHITE))
        if @@cder == 5
          atack_range = Sprite.new(@@cx, @@cy + 30, Image.new(20, 25, C_WHITE))
        end
        if enemy === atack_range && @@one_atack == 1
          @@one_atack = 0
          Fighting.atack(enemy_data, 0)
        end
      else
        @@one_atack = 0
        @@ca = 0
      end
    else
      if @@e_atack_time >= 1
        @@ea = 1
        enemy = Sprite.new(@@cx + 10, @@cy + 5, Image.new(65, 70, C_BLACK))
        atack_range = Sprite.new(@@ex + 45, @@ey + 20, Image.new(20, 25, C_WHITE))
        if @@eder == 0
          atack_range = Sprite.new(@@ex, @@ey + 30, Image.new(20, 25, C_WHITE))
        end
        if enemy === atack_range && @@e_atack_flag == 0
          @@e_atack_flag = 1
          Fighting.atack(enemy_data, 1)
        end
      else
        @@ea = 0
        @@e_atack_flag = 0
      end
    end
  end


  def self.wait(enemy_data)
    if Op_update.AnyKey_push? || Input.key_push?(K_RETURN)
      case(@@s_f)
      when 1
        @@s_f = 0
      when 2
        @@change = 3
      when 3
        @@s_f = 4
        $player.exp = $player.exp + enemy_data.state["exp"]
        $player.g_exp = $player.g_exp + enemy_data.state["exp"]
        $player.g_money = $player.g_money + enemy_data.state["money"]
        $player.k_monster = $player.k_monster + 1
      when 4
        if $player.lv_up?
          @@s_f = 5
        else
          @@change = 2
        end
      when 5
        @@change = 2
      end
    end
  end


  def self.move(enemy_data)
    case(@@s_f)
    when 0
      Fighting.ple_move
      Fighting.jump(0, enemy_data) if @@jump_flag == 1
      Fighting.hit(enemy_data, 0)
      t = @@e_jump_flag
      @@ex, @@e_jump_flag, @@eder, @@e_atack_time = enemy_data.move(@@ex, @@e_jump_flag)
      Fighting.hit(enemy_data, 1)
      if @@e_jump_flag == 1
        Fighting.jump(1, enemy_data)
        @@ev = enemy_data.state["jump"] + 10 if t == 0
      end
      if Fighting.die?(enemy_data, 1)
        @@s_f = 3
      end
      if Fighting.die?(enemy_data, 0)
        @@s_f = 2
      end
    when 1, 2, 3, 4, 5
      Fighting.wait(enemy_data)
    end
  end


  def self.draw(enemy_name, enemy_img, enemy_data)
    Fighting.move(enemy_data)
    Sprite.draw([@@back_ground, @@back_ground2])
    @@image = 0
    case($player.skin)
    when 0
      @@image = Image.load("image/yuusya#{@@cder}-#{@@ca}.png").set_color_key(C_WHITE)
    when 1
      @@image = Image.load("image/tako#{@@cder}-#{@@ca}.png").set_color_key(C_WHITE)
    when 2
      @@image = Image.load("image/ika#{@@cder}-#{@@ca}.png").set_color_key(C_RED)
    end
    @@player = Sprite.new(@@cx, @@cy, @@image)
    @@enemy = Sprite.new(@@ex, @@ey, enemy_img[@@eder * 2 + @@ea])
    Sprite.draw([@@player, @@enemy])
    
    case(@@s_f)
    when -1
      @@board1 = Sprite.new(0, 0, Image.new(600, 300 - @@time, C_BLACK))
      @@board2 = Sprite.new(0, 300 + @@time, Image.new(600, 300 - @@time, C_BLACK))
      @@time += 10
      Sprite.draw([@@board1, @@board2])
  
      if @@time >= 300
        @@time = 0
        @@s_f = 1
      end
    when 0
      @@hb1 = Sprite.new(5, 5, Image.new(244, 34, C_WHITE))
      @@bb1 = Sprite.new(7, 7, Image.new(240, 30, C_BLACK))
      Sprite.draw([@@hb1, @@bb1])
      Window.draw_font(7, 7, "#{$player.name} HP: #{$player.hp}/#{$player.hp_max}", $font_30)

      @@hb2 = Sprite.new(346, 5, Image.new(254, 64, C_WHITE))
      @@bb2 = Sprite.new(348, 7, Image.new(250, 60, C_BLACK))
      Sprite.draw([@@hb2, @@bb2])
      Window.draw_font(348, 7, "#{enemy_name}", $font_30)
      Window.draw_font(348, 37, "HP: #{enemy_data.state["hp"]}/#{enemy_data.state["hp_max"]}", $font_30)

      case(enemy_data.state["zokusei"])
      when 1
        Window.draw_font(568, 7, "火", $font_30)
      when 2
        Window.draw_font(568, 7, "水", $font_30)
      when 3
        Window.draw_font(568, 7, "木", $font_30)
      end
    when 1, 2, 3, 4
      @@h_b1 = Sprite.new(5, 350, Image.new(590, 245, C_WHITE))
      @@b_b1 = Sprite.new(7, 352, Image.new(586, 241, C_BLACK))
      Sprite.draw([@@h_b1, @@b_b1])
      case(@@s_f)
      when 1
        Window.draw_font(7, 352, "#{enemy_name}が現れた", $font_20)
      when 2
        Window.draw_font(7, 352, "#{$player.name}は倒れた", $font_20)
      when 3
        Window.draw_font(7, 352, "#{enemy_name}は倒れた", $font_20)
      when 4
        Window.draw_font(7, 352, "経験値:#{enemy_data.state["exp"]}　お金:#{enemy_data.state["money"]} 獲得!", $font_20)
      when 5
        Window.draw_font(7, 352, "#{$plyer.name}はレベルが上がった!!", $font_20)
      end
    end

    if @@change != 0
      num = @@change
      @@cx = 100
      @@cy = 300
      @@cder = 4
      @@ca = 0
      @@ex = 500
      @@ey = 300
      @@eder = 0
      @@ea = 0
      @@s_f = -1
      @@time = 0
      @@jump_time = 0
      @@jump_flag = 0
      @@e_jump_flag = 0
      @@e_jump_time = 0
      @@e_atack_time = 0
      @@e_atack_flag = 0
      @@v = 0
      @@ev = 0
      @@one_atack = 0
      @@change = 0
      return num, enemy_data
    else
      return 0, enemy_data
    end
  end
end