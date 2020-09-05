require_relative '../opening/op_update'
require_relative '../chara_state/rpg_enemy'

class Rpg
  @@back_guraund = Sprite.new(0, 0, Image.new(600, 600, C_GREEN))
  @@black_circle = Image.load('image/hoal.png')
  @@black_circle.set_color_key(C_WHITE)
  @@s_f = 0
  @@time = 0
  @@sel = 0
  @@sos = 0
  @@change = 0
  @@status = 0
  @@num = 0
  @@rate = 0
  @@die_flag = 0
  @@lv_up_flag = 0
  @@enemy_waza = 0
  @@turn = 0

  def self.wait(enemy_data)
    if Op_update.AnyKey_push? || Input.key_push?(K_RETURN)
      case(@@s_f)
      when 1
        @@turn += 1
        @@s_f = 2
      when 6
        @@s_f = 0
        @@change = 1
      when 7, 10
        @@s_f = 11
        @@rate = Rpg.a_p?(0)
        enemy_data.state["hp"] = enemy_data.state["hp"] - Rpg.damage(0, enemy_data)
        enemy_data.state["hp"] = [enemy_data.state["hp"], 0].max
        $player.r_mp = $player.r_mp - $player.waza[@@sos]["mp"]
      when 8, 9
        @@s_f = 12
        @@rate = Rpg.a_p?(1)
        $player.hp = $player.hp - Rpg.damage(1, enemy_data)
        $player.hp = [$player.hp, 0].max
      when 11
        if @@status == 1
          @@s_f = 9
        else
          enemy_data.heal_mp
          @@turn += 1
          @@s_f = 2
        end
        if Rpg.die?(1, enemy_data)
          @@s_f = 13
        end
      when 12
        if @@status == 2
          @@s_f = 10
        else
          $player.heal_mp
          @@turn += 1
          @@s_f = 2
        end
        if Rpg.die?(0, enemy_data)
          @@s_f = 14
        end
      when 13
        $player.g_money = $player.g_money + enemy_data.state["money"]
        $player.g_exp = $player.g_exp + enemy_data.state["exp"]
        $player.exp = $player.exp + enemy_data.state["exp"]
        $player.k_monster = $player.k_monster + 1
        if $player.lv_up?
          @@s_f = 16
        else
          @@s_f = 15
        end
      when 14
        @@change = 3
      when 15, 16
        @@change = 2
      when 17
        @@s_f = 3
      when 18
        @@s_f = 19
        num = [4, 12]
        cnt = 0
        ok = []
        num.size.times do |i|
          if $player.item[num[i]] != 0
            cnt += 1
            ok.push(num[i])
          end
        end
        enemy_data.state["hp"] = enemy_data.state["hp"] - Item.menu[ok[@@sos]]["damage"]
        enemy_data.state["hp"] = [0, enemy_data.state["hp"]].max
        $player.item_take(ok[@@sos])
      when 19
        if Rpg.die?(1, enemy_data)
          @@s_f = 13
        else
          @@s_f = 9
        end
      end
    end
  end


  def self.damage(num, enemy_data)
    sum = 0
    case(num)
    when 0
      sum += $player.atack
      sum += $player.state["waza"][@@sos]["atack"]
      case(enemy_data.state["zokusei"])
      when 1
        sum += $player.state["k_fire"]
        sum += $player.state["waza"][@@sos]["k_fire"]
      when 2
        sum += $player.state["k_water"]
        sum += $player.state["waza"][@@sos]["k_water"]
      when 3
        sum += $player.state["k_tree"]
        sum += $player.state["waza"][@@sos]["k_tree"]
      end

      if @@rate == 1
        sum *= 2
      end

      sum = [1, sum].max
      sum -= enemy_data.state["block"]
    when 1
      sum += enemy_data.state["atack"]
      sum += enemy_data.state["waza"][@@enemy_waza]["atack"]
      case(enemy_data.state["zokuesi"])
      when 1
        sum -= $player.state["b_fire"]
      when 2
        sum -= $player.state["b_water"]
      when 3
        sum -= $player.state["b_tree"]
      end
      sum -= $player.block

      sum = [1, sum].max
      if @@rate == 1
        sum = 0
      end
    end

    return sum
  end


  def self.a_p?(num)
    a = 0
    seed = Random.new(Time.now.to_i)
    r = seed.rand(100)
    case(num)
    when 0
      if r <= $player.p_r
        a = 1
      end
    when 1
      if r <= $player.a_r
        a = 1
      end
    end

    return a
  end


  def self.die?(num, enemy_data)
    case(num)
    when 0
      if $player.hp <= 0
        return true
      else
        return false
      end
    when 1
      if enemy_data.state["hp"] <= 0
        return true
      else
        return false
      end
    end
  end


  def self.battle(enemy_data)
    if $player.state["speed"] + $player.waza[@@sos]["speed"] >= enemy_data.state["speed"] + enemy_data.state["waza"][@@enemy_waza]["speed"]
      @@status = 1
      @@s_f = 7
    else
      @@status = 2
      @@s_f = 8
    end
  end

  
  def self.sel(enemy_data)
    if Input.key_push?(K_RETURN)
      case(@@s_f)
      when 2
        if @@sel != 2 && (@@sel != 1 || $player.state["item"].size != 0)
          @@s_f = 3 + @@sel
          if @@s_f == 3
            @@enemy_waza = enemy_data.waza_sel
          end
        end
      when 3
        if $player.r_mp < $player.waza[@@sos]["mp"]
          @@s_f = 17
          return 0
        end
        Rpg.battle(enemy_data)
      when 4
        @@s_f = 18
      end
    end
    case(@@s_f)
    when 2
      if Input.key_push?(K_W)
        @@sel -= 1
      end
      if Input.key_push?(K_S)
        @@sel += 1
      end
      @@sel = (@@sel + 4) % 4
    when 3
      if Input.key_push?(K_W)
        @@sos -= 1
      end
      if Input.key_push?(K_S)
        @@sos += 1
      end
      if Input.key_push?(K_A) || Input.key_push?(K_T) || Input.key_push?(K_ESCAPE)
        @@s_f = 2
        @@sos = 0
      end
      @@sos = (@@sos + $player.waza.size) % $player.waza.size
    when 4
      if Input.key_push?(K_W)
        @@sos -= 1
      end
      if Input.key_push?(K_S)
        @@sos += 1
      end
      if Input.key_push?(K_A) || Input.key_push?(K_T) || Input.key_push?(K_ESCAPE)
        @@sos = 0
        @@s_f = 2
      end
      num = [4, 12]
      cnt = 0
      num.size.times do |i|
        if $player.item[num[i]] != 0
          cnt += 1
        end
      end
      @@sos = (@@sos + cnt) % cnt
    end
  end


  def self.move(enemy_data)
    case(@@s_f)
    when 1, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
      Rpg.wait(enemy_data)
    when 2, 3, 4
      Rpg.sel(enemy_data)
    end
  end


  def self.draw(enemy_image, enemy_name, enemy_data)
    Rpg.move(enemy_data)
    Sprite.draw([@@back_guraund])
    Window.draw(100, 50, @@black_circle)
    if @@s_f != 13 && @@s_f != 15 && @@s_f != 16
      Window.draw_scale(255, 160, enemy_image, 3, 3)
    end

    #コマンド、メッセージ表示
    case(@@s_f)
    when 0, 1, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 18, 19
      @@h_b1 = Sprite.new(5, 350, Image.new(590, 245, C_WHITE))
      @@b_b1 = Sprite.new(7, 352, Image.new(586, 241, C_BLACK))
      Sprite.draw([@@h_b1, @@b_b1])
    else
      @@h_b1 = Sprite.new(5, 350, Image.new(155, 245, C_WHITE))
      @@b_b1 = Sprite.new(7, 352, Image.new(151, 241, C_BLACK))
      @@h_b2 = Sprite.new(161, 350, Image.new(434, 245, C_WHITE))
      @@b_b2 = Sprite.new(163, 352, Image.new(430, 241, C_BLACK))
      if @@sel == 0 || @@sel == 1
        @@h_b2 = Sprite.new(161, 350, Image.new(264, 245, C_WHITE))
        @@b_b2 = Sprite.new(163, 352, Image.new(260, 241, C_BLACK))
      end
      Sprite.draw([@@h_b1, @@b_b1, @@h_b2, @@b_b2])
      
      Window.draw_font(37, 352, "攻撃", $font_30)
      Window.draw_font(37, 382, "アイテム", $font_30)
      Window.draw_font(37, 412, "ステ確認", $font_30)
      Window.draw_font(37, 442, "逃げる", $font_30)
      Window.draw_font(7, @@sel * 30 + 352, "◎", $font_30)

      case(@@sel)
      when 0
        num = $player.waza.size
        if num >= 8
          num = 8
        end
        cn = @@sos - 4
        if cn + 8 > $player.waza.size
          cn = $player.waza.size - 8
        end
        if cn <= 0
          cn = 0
        end
        n = cn
        num.times do |i|
          Window.draw_font(193, i * 30 + 352, "#{$player.waza[cn]["name"]}", $font_30)
          cn += 1
        end
        Window.draw_font(163, (@@sos - n) * 30 + 352, "◎", $font_30) if @@s_f == 3 || @@s_f == 4

        @@h_b3 = Sprite.new(425, 350 , Image.new(174, 245, C_WHITE))
        @@b_b3 = Sprite.new(427, 352 , Image.new(170, 241, C_BLACK))
        Sprite.draw([@@h_b3, @@b_b3])

        #技の説明
        str = ["mp", "atack", "speed", "k_fire", "k_water", "k_tree"]
        s_j = ["消費MP", "攻撃力", "速度", "火キラー", "水キラー", "木キラー"]
        cnt = 0
        str.size.times do |i|
          if $player.waza[@@sos][str[i]] != 0
            Window.draw_font(427, 352 + 20 * cnt, s_j[i], $font_20)
            Window.draw_font(587 - Math.log10($player.waza[@@sos][str[i]]).floor * 10, 352 + 20 * cnt, "#{$player.waza[@@sos][str[i]]}", $font_20)
            cnt += 1
          end
        end

      when 1
        num = [4, 12]
        cnt = 0
        ok = []
        num.size.times do |i|
          if $player.item[num[i]] != 0
            Window.draw_font(193, cnt * 30 + 352, "#{Item.menu[num[i]]["name"]} × #{$player.item[num[i]]}", $font_30)
            cnt += 1
            ok.push(num[i])
          end
        end
        
        @@h_b3 = Sprite.new(425, 350 , Image.new(174, 245, C_WHITE))
        @@b_b3 = Sprite.new(427, 352 , Image.new(170, 241, C_BLACK))
        Sprite.draw([@@h_b3, @@b_b3])
        Window.draw_font(427, 352, "ダメージ", $font_30)
        Window.draw_font(577 - "#{Item.menu[ok[@@sos]]["damage"]}".size * 15, 352, "#{Item.menu[ok[@@sos]]["damage"]}", $font_30)

        Window.draw_font(163, @@sos * 30 + 352, "◎", $font_30) if @@s_f == 3 || @@s_f == 4
      when 2
        str = ["atack", "speed", "block", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r"]
        s_j = ["攻撃力", "速さ", "防御力", "火キラー", "水キラー", "木キラー", "火耐性", "水耐性", "木耐性", "会心率", "回避率"]
        str.size.times do |i|
          Window.draw_font(163, i * 20 + 352, "#{s_j[i]}:#{$player.state[str[i]]}", $font_20)
        end

      when 3
        Window.draw_font(163, 352, "戦闘から逃げ出します", $font_30)
      end
    end

    #簡易ステータス
    if (@@s_f >= 2 && @@s_f <= 4) || (@@s_f >= 7 && @@s_f <= 19)
      #敵のステータス
      @@h_b2 = Sprite.new(250, 5, Image.new(348, 64, C_WHITE))
      @@b_b2 = Sprite.new(252, 7, Image.new(344, 60, C_BLACK))
      Sprite.draw([@@h_b2, @@b_b2])

      Window.draw_font(252, 7, "#{enemy_name}", $font_30)
      Window.draw_font(252, 37, "HP: #{enemy_data.state["hp"]} / #{enemy_data.state["hp_max"]}", $font_30)

      case(enemy_data.state["zokusei"])
      when 1
        Window.draw_font(566, 7, "火", $font_30)
      when 2
        Window.draw_font(566, 7, "水", $font_30)
      when 3
        Window.draw_font(566, 7, "木", $font_30)
      end
      #自分のステータス
      @@h_b3 = Sprite.new(5, 280, Image.new(408, 64, C_WHITE))
      @@b_b3 = Sprite.new(7, 282, Image.new(404, 60, C_BLACK))
      Sprite.draw([@@h_b3, @@b_b3])

      Window.draw_font(7, 282, "#{$player.name}", $font_30)
      Window.draw_font(7, 312, "HP: #{$player.state["hp"]} / #{$player.state["hp_max"]} MP:#{$player.state["r_mp"]}/#{$player.state["r_mp_max"]}", $font_30)

      #ターン
      @@h_b4 = Sprite.new(5, 5, Image.new(214, 34, C_WHITE))
      @@b_b4 = Sprite.new(7, 7, Image.new(210, 30, C_BLACK))
      Sprite.draw([@@h_b4, @@b_b4])

      Window.draw_font(7, 7, "ターン: #{@@turn}", $font_30)

      #MP不足により技が使えないとき
      if @@s_f == 17
        @@h_b4 = Sprite.new(240, 300, Image.new(120, 39, C_WHITE))
        @@b_b4 = Sprite.new(242, 302, Image.new(116, 35, C_BLACK))
        Sprite.draw([@@h_b4, @@b_b4])

        Window.draw_font(252, 302, "MP不足!", $font_30)
      end
    end

    case(@@s_f)
    when 0
      @@time += 10
      @@b_board1 = Sprite.new(0, 0, Image.new(600, 300 - @@time, C_BLACK))
      @@b_board2 = Sprite.new(0, 600 - (300 - @@time), Image.new(600, 300 - @@time, C_BLACK))
      Sprite.draw([@@b_board1, @@b_board2])

      if @@time >= 290
        @@s_f = 1
        @@time = 0
      end
    when 1
      Window.draw_font(7, 352, "#{enemy_name}が現れた", $font_20)
    when 6
      Window.draw_font(7, 352, "#{$player.name}は逃げ去った", $font_20)
    when 7, 10
      Window.draw_font(7, 352, "#{$player.name}の#{$player.waza[@@sos]["name"]}", $font_20)
    when 8, 9
      Window.draw_font(7, 352, "#{enemy_name}の#{enemy_data.state["waza"][@@enemy_waza]["name"]}", $font_20)
    when 11
      num = 0
      if @@rate == 1
        Window.draw_font(7, 352, "会心の一撃!!!!", $font_20)
        num += 1
      end
      Window.draw_font(7, num * 20 + 352, "#{enemy_name}に#{Rpg.damage(0, enemy_data)}のダメージ", $font_20)
    when 12
      if @@rate == 1
        Window.draw_font(7, 352, "#{$player.name}はうまくかわした", $font_20)
      else
        Window.draw_font(7, 352, "#{$player.name}に#{Rpg.damage(1, enemy_data)}のダメージ", $font_20)
      end
    when 13
      Window.draw_font(7, 352, "#{enemy_name}は倒れた", $font_20)
    when 14
      Window.draw_font(7, 352, "#{$player.name}は倒れた", $font_20)
    when 15
      Window.draw_font(7, 352, "経験値:#{enemy_data.state["exp"]} お金:#{enemy_data.state["money"]} 獲得", $font_20)
    when 16
      Window.draw_font(7, 352, "#{$player.name}はレベルが上がった!!", $font_20)
    when 18
      num = [4, 12]
      ok = []
      cnt = 0
      num.size.times do |i|
        if $player.item[num[i]] != 0
          cnt += 1
          ok.push(num[i])
        end
      end
      Window.draw_font(7, 352, "#{$player.name}の#{Item.menu[ok[@@sos]]["name"]}", $font_20)
    when 19
      num = [4, 12]
      ok = []
      cnt = 0
      num.size.times do |i|
        if $player.item[num[i]] != 0
          cnt += 1
          ok.push(num[i])
        end
      end
      Window.draw_font(7, 352, "#{enemy_name}に#{Item.menu[ok[@@sos]]["damage"]}のダメージ", $font_20)
    end

    if @@change != 0
      num = @@change
      @@change = 0
      @@s_f = 0
      @@sos = 0
      @@sel = 0
      @@turn = 0
      $player.r_mp = $player.r_mp_max
      return num, enemy_data
    end
    return @@change, enemy_data
  end
end