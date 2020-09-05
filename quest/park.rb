require_relative '../effect/hotel'
require_relative '../effect/horo'
require_relative '../effect/weapon'
require_relative '../effect/item'
require_relative '../effect/quest_menu'
require_relative '../opening/op_update'

class Park
  @@x = 2
  @@y = 6
  @@p_f = 0
  @@sel = 0
  @@sos = 0
  @@sos2 = 0
  @@con = 0
  @@s = 0
  @@time = 1
  @@h_com = 0
  @@g_m = 0
  @@star_x = 300
  @@star_y = 50
  @@result = 0
  @@msg_num = 0
  @@der = 2
  @@chenge = 0

  #マップ情報
  @@map = [
    [2, 2, 0, 0, 0, 0, 2, 2],
    [2, 2, 0, 0, 0, 0, 2, 2],
    [2, 2, 0, 0, 0, 0 ,2, 2],
    [2, 2, 0, 0, 0, 0, 2, 2],
    [3, 1, 0, 0, 0, 0, 1, 4],
    [5, 1, 0, 0, 0, 0, 1, 8],
    [1, 1, 0, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 0, 1, 1],
    [1, 1, 0, 0, 0, 0, 1, 1],
    [3, 1, 0, 0, 0, 0, 1, 4],
    [7, 1, 0, 0, 0, 0, 1, 6]
  ]

  #写真の宣言
  @@load = Image.load('image/load.png')
  @@grass = Image.load('image/grass.png')
  @@tree = Image.load('image/tree.png')
  @@store_left = Image.load('image/store_human_left.png')
  @@store_right = Image.load('image/store_human_right.png')
  @@soad = Image.load('image/soad.png')
  @@store = Image.load('image/store.png')
  @@horo = Image.load('image/horo.png')
  @@hotel = Image.load('image/hotel.png')
  @@star = Image.load('image/star.png')

  #透明化
  @@store_left.set_color_key(C_WHITE)
  @@store_right.set_color_key(C_WHITE)
  @@star.set_color_key(C_WHITE)

  def self.ple_move
    if Input.key_push?(K_W) && @@y > 0 && @@map[@@y - 1][@@x] != 2
      if @@y - 1 == 5 && @@x == 7
        @@p_f = 8
        @@p_f = 4 if $player.skip == 1
      elsif @@y - 1 == 1
        @@p_f = 32
      elsif @@y - 1 == 5 && @@x == 0
        @@p_f = 25
        @@p_f = 26 if $player.skip == 1
      else
        @@y -= 1
      end
      @@der = 0
    end
    if Input.key_push?(K_A) && @@x > 0 && @@map[@@y][@@x - 1] != 2
      if @@x - 1 == 0 && (@@y == 9 || @@y == 10)
        @@p_f = 11
        @@p_f = 12 if $player.skip == 1
      elsif @@x - 1 == 0 && (@@y == 4 || @@y == 5)
        @@p_f = 25
        @@p_f = 26 if $player.skip == 1
      else
        @@x -= 1
      end
      @@der = 3
    end
    if Input.key_push?(K_S) && @@y < @@map.size - 1 && @@map[@@y + 1][@@x] != 2
      if @@y + 1 == 9 && @@x == 0
        @@p_f = 11
        @@p_f = 12 if $player.skip == 1
      elsif @@y + 1 == 9 && @@x == 7
        @@p_f = 19
        @@p_f = 20 if $player.skip == 1
      else
        @@y += 1
      end
      @@der = 2
    end
    if Input.key_push?(K_D) && @@x < @@map[0].size - 1 && @@map[@@y][@@x + 1] != 2
      if @@x + 1 == 7 && (@@y == 4 || @@y == 5)
        @@p_f = 8
        @@p_f = 4 if $player.skip == 1
      elsif @@x + 1 == 7 && (@@y == 9 || @@y == 10)
        @@p_f = 19
        @@p_f = 20 if $player.skip == 1
      else
        @@x += 1
      end
      @@der = 1
    end
    if Input.key_push?(K_T)
      @@p_f = 1
    end
  end

  
  def self.menu_sel
    if Input.key_push?(K_W)
      @@sel -= 1
    end
    if Input.key_push?(K_S)
      @@sel += 1
    end
    @@sel = (@@sel + 6) % 6


    if Input.key_push?(K_T) || Input.key_push?(K_ESCAPE)
      @@sel = 0
      @@p_f = 0
    end


    if Input.key_push?(K_RETURN) || Input.key_push?(K_D)
      case(@@sel)
      when 1
        @@p_f = 34
      when 2
        num = 0
        $player.item.size.times do |i|
          if $player.item[i] != 0
            num += 1
          end
        end
        if num != 0
          @@p_f = 36
        end
      end
    end


    if Input.key_push?(K_RETURN) && @@sel == 5
      @@chenge = -1
    end


    if (Input.key_push?(K_RIGHT) || Input.key_push?(K_RETURN) || Input.key_push?(K_D)) && @@sel == 4
      @@p_f = 2
    end
  end
  

  def self.equ_sel
    if Input.key_push?(K_W)
      @@sos -= 1
    end
    if Input.key_push?(K_S)
      @@sos += 1
    end
    @@sos = (@@sos + 9) % 9

    if Input.key_push?(K_A) || Input.key_push?(K_T) || Input.key_push?(K_ESCAPE)
      @@p_f = 1
      @@sos = 0
    end
    if Input.key_push?(K_RETURN)
      @@p_f = 35 if $player.equi[Weapon.sel_to_str(@@sos)].size != 0
    end
  end


  def self.equ_sel2
    if Input.key_push?(K_W)
      @@sos2 -= 1
    end
    if Input.key_push?(K_S)
      @@sos2 += 1
    end
    @@sos2 = (@@sos2 + $player.equi[Weapon.sel_to_str(@@sos)].size) % $player.equi[Weapon.sel_to_str(@@sos)].size

    if Input.key_push?(K_A) || Input.key_push?(K_T) || Input.key_push?(K_ESCAPE)
      @@p_f = 34
      @@sos2 = 0
    end
    if Input.key_push?(K_RETURN)
      $player.equi_set(Weapon.sel_equi_to_str(@@sos), $player.equi[Weapon.sel_to_str(@@sos)][@@sos2])
    end
  end


  def self.item_sel2
    if Input.key_push?(K_W)
      @@sos -= 1
    end
    if Input.key_push?(K_S)
      @@sos += 1
    end
    num = 0
    $player.item.size.times do |i|
      if $player.item[i] != 0
        num += 1
      end
    end
    @@sos = (@@sos + num) % num

    if Input.key_push?(K_A) || Input.key_push?(K_T) || Input.key_push?(K_ESCAPE)
      @@p_f = 1
      @@sos = 0
    end
    if Input.key_push?(K_RETURN)
      @@p_f = 37
    end
  end

  def self.data_sel
    if Input.key_push?(K_W)
      @@sos -= 1
    end
    if Input.key_push?(K_S)
      @@sos += 1
    end
    @@sos = (@@sos + 4) % 4

    if Input.key_push?(K_RETURN)
      if File.exist?("data/data#{@@sos}.txt")
        @@p_f = 3
      else
        Data.write(@@sos)
      end
    end
    if Input.key_push?(K_T)
      @@sel = 0
      @@sos = 0
      @@p_f = 0
    end
    if Input.key_push?(K_ESCAPE) || Input.key_push?(K_LEFT) || Input.key_push?(K_A)
      @@sel = 0
      @@sos = 0
      @@p_f = 1
    end
  end

  def self.item_sel
    if Input.key_push?(K_W)
      @@sel -= 1
    end
    if Input.key_push?(K_S)
      @@sel += 1
    end
    @@sel = (@@sel + Item.can_num) % Item.can_num

    if Input.key_push?(K_RETURN)
      @@p_f = 21
    end

    if Input.key_push?(K_ESCAPE) || Input.key_push?(K_LEFT) || Input.key_push?(K_A) || Input.key_push?(K_T)
      @@sel = 0
      @@p_f = 24
      @@p_f = 0 if $player.skip == 1
    end
  end


  #確認用
  def self.con_sel
    if Input.key_push?(K_A)
      @@s -= 1
    end
    if Input.key_push?(K_D)
      @@s += 1
    end

    @@s = (@@s + 2) % 2
    if Input.key_push?(K_RETURN)
      case(@@p_f)
      when 3
        @@p_f = 2
        if @@s == 0
          Data.write(@@sos)
        end
        @@s = 0


      when 5
        @@p_f = 4
        if @@s == 0
          num = Hotel.stay(@@sel)
          if num == -1
            @@p_f = 6
          else
            @@p_f = 7
          end
        end
        @@s = 0


      when 13
        @@p_f = 12
        if @@s == 0
          @@result = Horo.horo(@@sel)
          if @@result == -1
            @@p_f = 14
          else
            @@p_f = 15
          end
        end
        @@s = 0


      when 21
        @@p_f = 20
        if @@s == 0
          num = Item.buy_item(@@sel)
          if num == 0
            @@p_f = 22
          else
            @@p_f = 23
          end
        end
        @@s = 0

      when 28
        @@p_f = 27
        if @@s == 0
          num = Weapon.buy_wea(@@sel, @@sos)
          if num == 0
            @@p_f = 29
          else
            @@p_f = 30
          end
        end
        @@s = 0

      when 37
        @@p_f = 36
        can_num = []
        $player.item.size.times do |i|
          if $player.item[i] != 0
            can_num.push(i)
          end
        end
        if @@s == 0
          num = Item.use_item_park(can_num[@@sos])
          if num == 0
            @@p_f = 38
          else
            @@p_f = 39
          end
        end
        @@s = 0

      end
    end
  end


  #入力待ち状態
  def self.wait
    if Op_update.AnyKey_push? || Input.key_push?(K_RETURN) || Input.key_push?(K_ESCAPE)
      case(@@p_f)
      when 6, 8
        @@p_f = 4
      when 10
        @@p_f = 9
      when 11, 14
        @@p_f = 12
      when 15
        @@p_f = 16
      when 17
        @@msg_num += 1
      when 9, 18, 24, 31
        @@sel = 0
        @@p_f = 0
      when 19, 22, 23
        @@p_f = 20
      when 25
        @@p_f = 26
      when 29, 30
        @@p_f = 27
      when 38, 39
        can_num = []
        $player.item.size.times do |i|
          if $player.item[i] != 0
            can_num.push(i)
          end
        end

        if @@p_f == 38
          $player.item_take(can_num[@@sos])
        end

        @@p_f = 36
        num = 0
        @@sos -= 1
        if $player.item[can_num[@@sos + 1]] != 0
          @@sos += 1
        end
        if @@sos < 0
          @@sos = 0
        end
        $player.item.size.times do |i|
          if $player.item[i] != 0
            num += 1
          end
        end
        if num == 0
          @@p_f = 1
        end

      end
    end
  end


  #宿
  def self.sel_hotel
    if Input.key_push?(K_W)
      @@sel -= 1
    end
    if Input.key_push?(K_S)
      @@sel += 1
    end
    if Input.key_push?(K_T) || Input.key_push?(K_ESCAPE) || Input.key_push?(K_A)
      @@sel = 0
      @@p_f = 9
      @@p_f = 0 if $player.skip == 1
    end

    @@sel = (@@sel + Hotel.can_num) % Hotel.can_num
    if Input.key_push?(K_RETURN)
      @@p_f = 5
    end
  end

  #占い
  def self.sel_horo
    if Input.key_push?(K_W)
      @@sel -= 1
    end
    if Input.key_push?(K_S)
      @@sel += 1
    end
    if Input.key_push?(K_T) || Input.key_push?(K_ESCAPE) || Input.key_push?(K_A)
      @@sel = 0
      @@p_f = 18
      @@p_f = 0 if $player.skip == 1
    end

    @@sel = (@@sel + Horo.can_num) % Horo.can_num
    if Input.key_push?(K_RETURN)
      @@p_f = 13
    end
  end

  #武器屋
  def self.sel_wea
    if Input.key_push?(K_W)
      @@sel -= 1
    end
    if Input.key_push?(K_S)
      @@sel += 1
    end
    if Input.key_push?(K_T) || Input.key_push?(K_ESCAPE) || Input.key_push?(K_A)
      @@sel = 0
      @@p_f = 31
      @@p_f = 0 if $player.skip == 1
    end

    @@sel = (@@sel + 9) % 9
    if Input.key_push?(K_RETURN) || Input.key_push?(K_D)
      @@p_f = 27
    end
  end

  #武器屋の中の武器
  def self.sos_wea
    if Input.key_push?(K_W)
      @@sos -= 1
    end
    if Input.key_push?(K_S)
      @@sos += 1
    end
    if Input.key_push?(K_T) || Input.key_push?(K_ESCAPE) || Input.key_push?(K_A)
      @@sos = 0
      @@p_f = 26
    end
  
    @@sos = (@@sos + Weapon.can_num(@@sel)) % Weapon.can_num(@@sel)
    if Input.key_push?(K_RETURN) || Input.key_push?(K_D)
      @@p_f = 28
    end
  end

  #クエスト選択
  def self.que_sel
    if Input.key_push?(K_W)
      @@sel -= 1
    end
    if Input.key_push?(K_S)
      @@sel += 1
    end
    if Input.key_push?(K_T) || Input.key_push?(K_ESCAPE) || Input.key_push?(K_A)
      @@sel = 0
      @@p_f = 0
    end
  
    @@sel = (@@sel + Quest_menu.can_num) % Quest_menu.can_num
    if Input.key_push?(K_RETURN) || Input.key_push?(K_D)
      @@p_f = 33
    end
  end

  #移動
  def self.move
    case(@@p_f)
    when 0
      Park.ple_move
    when 1
      Park.menu_sel
    when 2
      Park.data_sel
    when 3, 5, 13, 21, 28, 37
      Park.con_sel
    when 4
      Park.sel_hotel
    when 6, 8, 9, 10, 11, 14, 15, 17, 18, 19, 22, 23, 24, 25, 29, 30, 31, 38, 39
      Park.wait
    when 12
      Park.sel_horo
    when 20
      Park.item_sel
    when 26
      Park.sel_wea
    when 27
      Park.sos_wea
    when 32
      Park.que_sel
    when 34
      Park.equ_sel
    when 35
      Park.equ_sel2
    when 36
      Park.item_sel2
    end
  end

  def self.draw
    num_x = @@x - 4
    num_y = @@y - 4

    #描画開始地点がデータ範囲外の時の処理
    num_x = 0 if num_x < 0
    num_y = 0 if num_y < 0
    num_x = @@map[0].size - 8 if num_x + 8 > @@map[0].size
    num_y = @@map.size - 8 if num_y + 8 > @@map.size

    #マップを描画
    y_i = 0
    for i in num_y .. num_y + 7
      x_i = 0
      for j in num_x .. num_x + 7
        case(@@map[i][j])
        when 0
          Window.draw(75 * x_i, 75 * y_i, @@load)
        when 1
          Window.draw(75 * x_i, 75 * y_i, @@grass)
        when 2
          Window.draw(75 * x_i, 75 * y_i, @@tree)
        when 3
          Window.draw(75 * x_i, 75 * y_i, @@grass)
          Window.draw(75 * x_i, 75 * y_i, @@store_left)
        when 4
          Window.draw(75 * x_i, 75 * y_i, @@grass)
          Window.draw(75 * x_i, 75 * y_i, @@store_right)
        when 5
          Window.draw(75 * x_i, 75 * y_i, @@soad)
        when 6
          Window.draw(75 * x_i, 75 * y_i, @@store)
        when 7
          Window.draw(75 * x_i, 75 * y_i, @@horo)
        when 8
          Window.draw(75 * x_i, 75 * y_i, @@hotel)
        end

        #プレイヤを表示
        if i == @@y && j == @@x
          image = 0
          case($player.skin)
          when 0
            image = Image.load("image/yuusya#{@@der}.png")
            image.set_color_key(C_WHITE)
          when 1
            image = Image.load("image/tako#{@@der}.png")
            image.set_color_key(C_WHITE)
          when 2
            image = Image.load("image/ika#{@@der}.png")
            image.set_color_key(C_RED)
          end

          Window.draw(75 * x_i, 75 * y_i, image)
        end
        x_i += 1
      end
      y_i += 1
    end

    #データの表示
    case(@@p_f)
    when 0
      @@h_b = Sprite.new(5, 5, Image.new(154, 94, C_WHITE))
      @@da_pl = Sprite.new(7, 7, Image.new(150, 90, C_BLACK))
      Sprite.draw([@@h_b, @@da_pl])

      Window.draw_font(7, 7, "#{$player.name}", $font_30)
      Window.draw_font(7, 37, "レベル: #{$player.lv}", $font_30)
      Window.draw_font(7, 67, "お金  : #{$player.money}", $font_30)
    when 1, 2, 3, 34, 35, 36, 37, 38, 39
      @@h_b = Sprite.new(5, 5, Image.new(184, 184, C_WHITE))
      @@b_b = Sprite.new(7, 7, Image.new(180, 180, C_BLACK))
      Sprite.draw([@@h_b, @@b_b])

      Window.draw_font(37, 7, "ステータス", $font_30)
      Window.draw_font(37, 37, "装備", $font_30)
      Window.draw_font(37, 67, "アイテム", $font_30)
      Window.draw_font(37, 97, "クリア履歴", $font_30)
      Window.draw_font(37, 127, "セーブ", $font_30)
      Window.draw_font(37, 157, "戻る", $font_30)
      Window.draw_font(7, @@sel * 30 + 7, "◎", $font_30)
      case(@@sel)
      when 0
        @@h_b2 = Sprite.new(185, 5, Image.new(354, 354, C_WHITE))
        @@b_b2 = Sprite.new(187, 7, Image.new(350, 350, C_BLACK))
        Sprite.draw([@@h_b2, @@b_b2])
        Window.draw_font(187, 7, "名前   #{$player.name}", $font_20)
        Window.draw_font(537 - "#{$player.name}".size * 10, 7, "#{$player.name}", $font_20)
        Window.draw_font(187, 27, "レベル", $font_20)
        Window.draw_font(537 - "#{$player.lv}".size * 10, 27, "#{$player.lv}", $font_20)
        Window.draw_font(187, 47, "お金", $font_20)
        Window.draw_font(537 - "#{$player.money}".size * 10, 47, "#{$player.money}", $font_20)
        Window.draw_font(187, 67, "HP", $font_20)
        Window.draw_font(537 - "#{$player.hp}/#{$player.hp_max}".size * 10, 67, "#{$player.hp}/#{$player.hp_max}", $font_20)
        Window.draw_font(187, 87, "攻撃力", $font_20)
        Window.draw_font(537 - "#{$player.atack}".size * 10, 87, "#{$player.atack}", $font_20)
        Window.draw_font(187, 107, "速さ", $font_20)
        Window.draw_font(537 - "#{$player.speed}".size * 10, 107, "#{$player.speed}", $font_20)
        Window.draw_font(187, 127, "防御力", $font_20)
        Window.draw_font(537 - "#{$player.block}".size * 10, 127, "#{$player.block}", $font_20)
        Window.draw_font(187, 147, "火キラー", $font_20)
        Window.draw_font(537 - "#{$player.k_fire}".size * 10, 147, "#{$player.k_fire}", $font_20)
        Window.draw_font(187, 167, "水キラー", $font_20)
        Window.draw_font(537 - "#{$player.k_water}".size * 10, 167, "#{$player.k_water}", $font_20)
        Window.draw_font(187, 187, "木キラー", $font_20)
        Window.draw_font(537 - "#{$player.k_tree}".size * 10, 187, "#{$player.k_tree}", $font_20)
        Window.draw_font(187, 207, "火耐性", $font_20)
        Window.draw_font(537 - "#{$player.k_fire}".size * 10, 207, "#{$player.b_fire}", $font_20)
        Window.draw_font(187, 227, "水耐性", $font_20)
        Window.draw_font(537 - "#{$player.b_water}".size * 10, 227, "#{$player.b_water}", $font_20)
        Window.draw_font(187, 247, "木耐性", $font_20)
        Window.draw_font(537 - "#{$player.b_tree}".size * 10, 247, "#{$player.b_tree}", $font_20)
        Window.draw_font(187, 267, "MP(RPG)", $font_20)
        Window.draw_font(537 - "#{$player.r_mp}/#{$player.r_mp_max}".size * 10, 267, "#{$player.r_mp}/#{$player.r_mp_max}", $font_20)
        Window.draw_font(187, 287, "ボール速度(シューティング)", $font_20)
        Window.draw_font(537 - "#{$player.boal_s}".size * 10, 287, "#{$player.boal_s}", $font_20)
        Window.draw_font(187, 307, "MP(シューティング)", $font_20)
        Window.draw_font(537 - "#{$player.b_mp}/#{$player.b_mp_max}".size * 10, 307, "#{$player.b_mp}/#{$player.b_mp_max}", $font_20)
        Window.draw_font(187, 327, "ジャンプ(格闘)", $font_20)
        Window.draw_font(537 - "#{$player.jump}".size * 10, 327, "#{$player.jump}", $font_20)
      when 1
        @@h_b2 = Sprite.new(185, 5, Image.new(194, 184, C_WHITE))
        @@b_b2 = Sprite.new(187, 7, Image.new(190, 180, C_BLACK))
        Sprite.draw([@@h_b2, @@b_b2])
        Window.draw_font(207,   7, "頭:",$font_20)
        Window.draw_font(207,  27, "腕:",$font_20)
        Window.draw_font(207,  47, "剣:",$font_20)
        Window.draw_font(207,  67, "盾:",$font_20)
        Window.draw_font(207,  87, "鎧:",$font_20)
        Window.draw_font(207, 107, "靴:",$font_20)
        Window.draw_font(207, 127, "守:",$font_20)
        Window.draw_font(207, 147, "眼:",$font_20)
        Window.draw_font(207, 167, "耳:",$font_20)
        
        str = ["head", "arm","sord", "seald", "armor", "shoes", "amulet", "eye", "ear"]
        str.size.times do |i|
          if $player.equi[str[i]] == 0
            Window.draw_font(247, i * 20 + 7, "[装備なし]", $font_20)
          else
            Window.draw_font(247, i * 20 + 7, $player.equi[str[i]]["name"], $font_20)
          end
        end

        if @@p_f == 34 || @@p_f == 35
          num_set = 0
          str = ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r"]
          s_j = ["攻撃力", "防御力", "速さ", "火キラー", "水キラー", "木キラー", "火耐性", "水耐性", "木耐性", "会心率", "回避率"]
          if $player.equi[Weapon.sel_equi_to_str(@@sos)] != 0
            str.size.times do |i|
              if $player.equi[Weapon.sel_equi_to_str(@@sos)][str[i]] != 0
                num_set += 1
              end
            end
          end

          Window.draw_font(187, @@sos * 20 + 7, "◎", $font_20)
          @@h_b3 = Sprite.new(185, 190, Image.new(214, (num_set + 1) * 20 + 4, C_WHITE))
          @@b_b3 = Sprite.new(187, 192, Image.new(210, (num_set + 1) * 20, C_BLACK))
          Sprite.draw([@@h_b3, @@b_b3])
          if $player.equi[Weapon.sel_equi_to_str(@@sos)] == 0
            Window.draw_font(187, 192, "[装備なし]", $font_20)
          else
            Window.draw_font(187, 192, "#{$player.equi[Weapon.sel_equi_to_str(@@sos)]["name"]}", $font_20)

            num = 0
            str.size.times do |i|
              if $player.equi[Weapon.sel_equi_to_str(@@sos)][str[i]] != 0
                Window.draw_font(207, (i - num) * 20 + 212, "#{s_j[i]}", $font_20)
                Window.draw_font(397 - "#{$player.equi[Weapon.sel_equi_to_str(@@sos)][str[i]]}".size * 10, (i - num) * 20 + 212, "#{$player.equi[Weapon.sel_equi_to_str(@@sos)][str[i]]}", $font_20)
              else
                num += 1
              end
            end
          end
          
          @@h_b4 = Sprite.new(377, 5, Image.new(194, [$player.equi[Weapon.sel_to_str(@@sos)].size, 1].max * 20 + 4, C_WHITE))
          @@b_b4 = Sprite.new(379, 7, Image.new(190, [$player.equi[Weapon.sel_to_str(@@sos)].size, 1].max * 20, C_BLACK))
          Sprite.draw([@@h_b4, @@b_b4])
          if $player.equi[Weapon.sel_to_str(@@sos)].size == 0
            Window.draw_font(379, 7, "[武器なし]", $font_20)
          end

          $player.equi[Weapon.sel_to_str(@@sos)].size.times do |i|
            Window.draw_font(399, i * 20 + 7, "#{$player.equi[Weapon.sel_to_str(@@sos)][i]["name"]}", $font_20)
          end
          if @@p_f == 35
            Window.draw_font(379, @@sos2 * 20 + 7, "◎", $font_20)

            num_now = 0
            str.size.times do |i|
              if $player.equi[Weapon.sel_to_str(@@sos)][@@sos2][str[i]] != 0
                num_now += 1
              end
            end
            
            @@h_b5 = Sprite.new(185, 190 + (num_set + 1) * 20 + 5, Image.new(214, (num_now + 1) * 20 + 4, C_WHITE))
            @@b_b5 = Sprite.new(187, 192 + (num_set + 1) * 20 + 5, Image.new(210, (num_now + 1) * 20, C_BLACK))
            Sprite.draw([@@h_b5, @@b_b5])
            Window.draw_font(187, 192 + (num_set + 1) * 20 + 5, "#{$player.equi[Weapon.sel_to_str(@@sos)][@@sos2]["name"]}", $font_20)
            num = 0
            str.size.times do |i|
              if $player.equi[Weapon.sel_to_str(@@sos)][@@sos2][str[i]] != 0
                Window.draw_font(207, num * 20 + 212 + (num_set + 1) * 20 + 5, "#{s_j[i]}", $font_20)
                Window.draw_font(397 - "#{$player.equi[Weapon.sel_to_str(@@sos)][@@sos2][str[i]]}".size * 10, num * 20 + 212 + (num_set + 1) * 20 + 5, "#{$player.equi[Weapon.sel_to_str(@@sos)][@@sos2][str[i]]}", $font_20)
                num += 1
              end
            end

          end
        end
      when 2
        num = 0
        $player.item.size.times do |i|
          if $player.item[i] != 0
            num += 1
          end
        end
        @@h_b2 = Sprite.new(185, 5, Image.new(184, [num, 1].max * 20 + 4, C_WHITE))
        @@b_b2 = Sprite.new(187, 7, Image.new(180, [num, 1].max * 20, C_BLACK))
        Sprite.draw([@@h_b2, @@b_b2])

        if num == 0
          Window.draw_font(187, 7, "NO ITEMS", $font_20)
        end
        num = 0
        $player.item.size.times do |i|
          if $player.item[i] == 0
            num += 1
            next
          end
          Window.draw_font(207, (i - num) * 20 + 7, "#{Item.menu[i]["name"]} × #{$player.item[i]}", $font_20)
        end

        if @@p_f >= 36 && @@p_f <= 39
          Window.draw_font(187, @@sos * 20 + 7, "◎", $font_20)

          #説明の表示
          can_num = []
          $player.item.size.times do |i|
            if $player.item[i] != 0
              can_num.push(i)
            end
          end

          case(Item.menu[can_num[@@sos]]["mode"])
          when 0
            num = 0
            str = ["heal", "atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree"]
            s_j = ["回復　　","攻撃力　", "防御力　", "速さ　　", "火キラー", "水キラー", "木キラー", "火耐性　", "水耐性　", "木耐性　"]
            str.size.times do |i|
              if Item.menu[can_num[@@sos]][str[i]] != 0
                num += 1
              end
            end
            if Item.menu[can_num[@@sos]]["expr"] != nil
              num = 5
            end
            @@h_b3 = Sprite.new(370, 5, Image.new(199, [num, 1].max * 20 + 4, C_WHITE))
            @@b_b3 = Sprite.new(372, 7, Image.new(195, [num, 1].max * 20, C_BLACK))
            Sprite.draw([@@h_b3, @@b_b3])

            if Item.menu[can_num[@@sos]]["expr"] == nil
              num = 0
              str.size.times do |i|
                if Item.menu[can_num[@@sos]][str[i]] != 0
                  Window.draw_font(372, num * 20 + 7, "#{s_j[i]}", $font_20)
                  Window.draw_font(567 - "#{Item.menu[can_num[@@sos]][str[i]]}".size * 10, num * 20 + 7, "#{Item.menu[can_num[@@sos]][str[i]]}", $font_20)
                  num += 1
                end
              end
            else 
              Window.draw_font(372, 7, "お金", $font_20)
              Window.draw_font(567 - "#{Item.menu[can_num[@@sos]]["money"]}".to_s.size * 10, 7, "#{Item.menu[can_num[@@sos]]["money"]}", $font_20)
              Window.draw_font(372, 27, "#{Item.menu[can_num[@@sos]]["expr"]}", $font_20)
            end

          when 1
            @@h_b3 = Sprite.new(370, 5, Image.new(199, 2 * 20 + 4, C_WHITE))
            @@b_b3 = Sprite.new(372, 7, Image.new(195, 2 * 20, C_BLACK))
            Sprite.draw([@@h_b3, @@b_b3])

            Window.draw_font(372, 7, "RPG用アイテム", $font_20)
            Window.draw_font(372, 27, "ダメージ #{Item.menu[can_num[@@sos]]["damage"]}", $font_20)
            Window.draw_font(567 - "#{Item.menu[can_num[@@sos]]["damage"]}".size * 10, 27, "#{Item.menu[can_num[@@sos]]["damage"]}", $font_20)
          when 2
            @@h_b3 = Sprite.new(370, 5, Image.new(199, [Item.menu[can_num[@@sos]]["waza_size"], 1].max * 20 + 4, C_WHITE))
            @@b_b3 = Sprite.new(372, 7, Image.new(195, [Item.menu[can_num[@@sos]]["waza_size"], 1].max * 20, C_BLACK))
            Sprite.draw([@@h_b3, @@b_b3])

            Item.menu[can_num[@@sos]]["waza_size"].times do |i|
              Window.draw_font(372, i * 20 + 7, "技#{i + 1}：#{Item.menu[can_num[@@sos]]["waza#{i}"]}", $font_20)
            end
          end


          if @@p_f == 37 || @@p_f == 38 || @@p_f == 39
            #ボード
            @@h_b4 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
            @@b_b4 = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
            Sprite.draw([@@h_b4, @@b_b4])
    
            #メッセージ
            Window.draw_font(187, 107, "使いますか?", $font_30)
            Window.draw_font(187, 137, "   はい    いいえ", $font_30)
            Window.draw_font(187 + @@s * 90, 137, "◎", $font_30)

            if @@p_f == 38 || @@p_f == 39
              @@h_b5 = Sprite.new(185, 135, Image.new(254, 34, C_WHITE))
              @@b_b5 = Sprite.new(187, 137, Image.new(250, 30, C_BLACK))
              Sprite.draw([@@h_b5, @@b_b5])

              if @@p_f == 38
                Window.draw_font(187, 135, "使用しました", $font_30)
              elsif @@p_f == 39
                Window.draw_font(187, 135, "ここでは使えません", $font_20)
              end
            end

          end
        end
      when 3
        @@h_b5 = Sprite.new(190, 5, Image.new(334, Quest_menu.can_num * 20 + 4, C_WHITE))
        @@b_b5 = Sprite.new(192, 7, Image.new(330, Quest_menu.can_num * 20, C_BLACK))
        Sprite.draw([@@h_b5, @@b_b5])

        Quest_menu.can_num.times do |i|
          Window.draw_font(192, i * 20 + 7, "#{Quest_menu.menu[i]}", $font_20)
          Window.draw_font(522 - "#{$player.result[i]}".size * 10, i * 20 + 7, "#{$player.result[i]}", $font_20)
        end
      when 4
        @@h_b2 = Sprite.new(185, 5, Image.new(254, 324, C_WHITE))
        @@b_b2 = Sprite.new(187, 7, Image.new(250, 320, C_BLACK))
        Sprite.draw([@@h_b2, @@b_b2])
        flag, lv = Data.exist?
        4.times do |i|
          Window.draw_font(227, 7 + 80 * i, "DATA#{i + 1}", $font_20)
          if flag[i] == 0
            Window.draw_font(247, 27 + 80 * i, "NO DATA", $font_20)
          else
            Window.draw_font(247, 27 + 80 * i, "#{flag[i]}", $font_20)
            Window.draw_font(247, 47 + 80 * i, "#{lv[i]}", $font_20)
          end
        end
        if @@p_f == 2
          Window.draw_font(187, 7 + @@sos * 80, "◎", $font_20)
        end
        if @@p_f == 3
          @@h_b3 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
          @@b_b3 = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
          @@h_b4 = Sprite.new(5, 345, Image.new(590, 254, C_WHITE))
          @@b_b4 = Sprite.new(7, 347, Image.new(586, 250, C_BLACK))
          Sprite.draw([@@h_b3, @@b_b3])
          Window.draw_font(187, 107, "上書きしますか?", $font_30)
          Window.draw_font(187, 137, "   はい    いいえ", $font_30)
          Window.draw_font(187 + @@s * 90, 137, "◎", $font_30)
        end
      when 5
        @@h_b2 = Sprite.new(185, 5, Image.new(284, 34, C_WHITE))
        @@b_b2 = Sprite.new(187, 7, Image.new(280, 30, C_BLACK))
        Sprite.draw([@@h_b2, @@b_b2])
        Window.draw_font(187, 7, "タイトルに戻ります", $font_30)
      end
    when 4, 5, 6, 8, 9, 10
      #ボード
      if @@p_f == 8 || @@p_f == 9#挨拶
        @@h_b = Sprite.new(5, 5, Image.new(154, 94, C_WHITE))
        @@da_pl = Sprite.new(7, 7, Image.new(150, 90, C_BLACK))
        @@h_b4 = Sprite.new(5, 355, Image.new(590, 244, C_WHITE))
        @@b_b4 = Sprite.new(7, 357, Image.new(586, 240, C_BLACK))
        Sprite.draw([@@h_b, @@da_pl, @@h_b4, @@b_b4])
        Window.draw_font(7, 7, "#{$player.name}", $font_30)
        Window.draw_font(7, 37, "レベル: #{$player.lv}", $font_30)
        Window.draw_font(7, 67, "お金  : #{$player.money}", $font_30)
      elsif @@p_f == 10 #メニュー選択
        @@h_b4 = Sprite.new(5, 355, Image.new(590, 244, C_WHITE))
        @@b_b4 = Sprite.new(7, 357, Image.new(586, 240, C_BLACK))
        Sprite.draw([@@h_b4, @@b_b4])
      else
        @@h_b = Sprite.new(5, 5, Image.new(184, 184, C_WHITE))
        @@b_b = Sprite.new(7, 7, Image.new(180, 180, C_BLACK))
        @@h_b2 = Sprite.new(185, 5, Image.new(184, Hotel.can_num * 20 + 4, C_WHITE))
        @@b_b2 = Sprite.new(187, 7, Image.new(180, Hotel.can_num * 20, C_BLACK))

        str = ["money", "heal", "atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "k_tree", "p_r", "a_r"]
        cnt = 0
        str.size.times do |i|
          if Hotel.menu[@@sel][str[i]] != 0
            cnt += 1
          end
        end
        @@h_b3 = Sprite.new(365, 5, Image.new(204, cnt * 20 + 4, C_WHITE))
        @@b_b3 = Sprite.new(367, 7, Image.new(200, cnt * 20, C_BLACK))
        @@h_b4 = Sprite.new(5, 355, Image.new(590, 244, C_WHITE))
        @@b_b4 = Sprite.new(7, 357, Image.new(586, 240, C_BLACK))
        Sprite.draw([@@h_b, @@b_b, @@h_b2, @@b_b2, @@h_b3, @@b_b3, @@h_b4, @@b_b4])
        #ステータス表示
        Window.draw_font(7, 7, "#{$player.name}", $font_30)
        Window.draw_font(7, 37, "レベル:#{$player.lv}", $font_30)
        Window.draw_font(7, 67, "お金  :#{$player.money}", $font_30)
        Window.draw_font(7, 97, "HP    :#{$player.hp}", $font_30)
        Window.draw_font(187 - "/#{$player.hp_max}".size * 15, 127, "/#{$player.hp_max}", $font_30)

        #メニュー
        Hotel.can_num.times do |i|
          Window.draw_font(207, 20 * i + 7, Hotel.menu[i]["name"], $font_20)
        end
        Window.draw_font(187, 20 * @@sel + 7, "◎", $font_20)

        #効果の表示
        str_n = ["お金　　", "回復　　", "力　 　　", "防御　　", "速さ　 　", "火キラー", "水キラー", "木キラー", "火耐性　", "水耐性　", "木耐性　", "会心率　", "回避率　"]
        cnt = 0
        str.size.times do |i|
          if Hotel.menu[@@sel][str[i]] == 0
            next
          end
          Window.draw_font(367, cnt * 20 + 7, "#{str_n[i]}", $font_20)
          Window.draw_font(567 - "#{Hotel.menu[@@sel][str[i]]}".size * 10, cnt * 20 + 7, "#{Hotel.menu[@@sel][str[i]]}", $font_20)
          cnt += 1
        end
      end

      #コメント
      if @@p_f == 8
        Window.draw_font(7, 357, "いらっしゃいませ", $font_20)
        Window.draw_font(7, 377, "「宿・クエバ」でございます", $font_20)
      elsif @@p_f == 10
        Window.draw_font(7, 357, "おはようございます!!!", $font_20)
        Window.draw_font(7, 377, "(By AAABBBEEE)", $font_20)
      elsif @@p_f == 9
        Window.draw_font(7, 357, "ご利用ありがとうございました。", $font_20)
        Window.draw_font(7, 377, "またのお越しをお待ちしております", $font_20)
      elsif @@p_f == 4
        Window.draw_font(7, 357, "宿泊メニューをお選びください", $font_20)
      end

      #確認
      if @@p_f == 5
        #ボード
        @@h_b4 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
        @@b_b4 = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
        Sprite.draw([@@h_b4, @@b_b4])

        #メッセージ
        Window.draw_font(187, 107, "泊まりますか?", $font_30)
        Window.draw_font(187, 137, "   はい    いいえ", $font_30)
        Window.draw_font(187 + @@s * 90, 137, "◎", $font_30)
      elsif @@p_f == 6
        #ボード
        @@h_b4 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
        @@b_b4 = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
        Sprite.draw([@@h_b4, @@b_b4])

        #メッセージ
        Window.draw_font(187, 107, "お金が足りません", $font_30)
      end
    when 7
      @@blind = []
      if @@time <= 75
        8.times do |i|
          @@blind.push(Sprite.new(0, (75 * (i + 1)) - @@time, Image.new(600, @@time, C_BLACK)))
        end
      else
        8.times do |i|
          @@blind.push(Sprite.new(0, (75 * (i)), Image.new(600, 150 - @@time, C_BLACK)))
        end
      end

      Sprite.draw(@@blind)
      @@time += 1
      @@time += 1 if $player.skip == 1
      if @@time >= 150
        @@time = 1
        @@p_f = 10
      end

    when 11, 12, 13, 14, 15, 17, 18
      @@h_b = Sprite.new(5, 5, Image.new(154, 94, C_WHITE))
      @@da_pl = Sprite.new(7, 7, Image.new(150, 90, C_BLACK))
      @@h_b4 = Sprite.new(5, 355, Image.new(590, 244, C_WHITE))
      @@b_b4 = Sprite.new(7, 357, Image.new(586, 240, C_BLACK))
      Sprite.draw([@@h_b, @@da_pl, @@h_b4, @@b_b4])
      Window.draw_font(7, 7, "#{$player.name}", $font_30)
      Window.draw_font(7, 37, "レベル: #{$player.lv}", $font_30)
      Window.draw_font(7, 67, "お金  : #{$player.money}", $font_30)
      if @@p_f == 12 || @@p_f == 13 || @@p_f == 14
        @@h_b5 = Sprite.new(160, 5, Image.new(404, Horo.can_num * 20 + 4, C_WHITE))
        @@b_b5 = Sprite.new(162, 7, Image.new(400, Horo.can_num * 20, C_BLACK))
        Sprite.draw([@@h_b5, @@b_b5])
        Horo.can_num.times do |i|
          Window.draw_font(182, i * 20 + 7, "#{Horo.menu[i]["name"]}", $font_20)
          Window.draw_font(482, i * 20 + 7, "お金:   #{Horo.menu[i]["money"]}", $font_20)
        end
        Window.draw_font(162, @@sel * 20 + 7, "◎", $font_20)
      end


      if @@p_f == 13
        #ボード
        @@h_b6 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
        @@b_b6  = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
        Sprite.draw([@@h_b6, @@b_b6])

        #メッセージ
        Window.draw_font(187, 107, "占いますか?", $font_30)
        Window.draw_font(187, 137, "   はい    いいえ", $font_30)
        Window.draw_font(187 + @@s * 90, 137, "◎", $font_30)
      elsif @@p_f == 14
        #ボード
        @@h_b6 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
        @@b_b6 = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
        Sprite.draw([@@h_b6, @@b_b6])

        #メッセージ
        Window.draw_font(187, 107, "お金が足りません", $font_30)        
      end

      #コメント
      case(@@p_f)
      when 11
        Window.draw_font(7, 357, "いらっしゃいませ!", $font_20)
        Window.draw_font(7, 377, "占いの館「Q」でございます", $font_20)
      when 12, 13, 14
        Window.draw_font(7, 357, "どの占いをいたしましょうか", $font_20)
      when 15
        case(@@sel)
        when 0
          Window.draw_font(7, 357, "では、手を(ご時世により洗ってから)見せてください",$font_20)
        when 1
          Window.draw_font(7, 357, "では、この水晶を投げてください", $font_20)
        when 2
          Window.draw_font(7, 357, "では、学生証を見せてください", $font_20)
        end
      when 17
        num = Horo.effect[@@result]["msg_size"]
        Window.draw_font(7, 357, "#{Horo.effect[@@result]["msg#{@@msg_num}"]}", $font_20)
        if @@msg_num == num
         @@msg_num = 0
         @@p_f = 18
        end
      when 18
        Window.draw_font(7, 357, "ご利用ありがとうございました。", $font_20)
        Window.draw_font(7, 377, "ご武運をお祈りします", $font_20)
      end

    when 16
      x = 0
      y = 0

      #軌道
      if @@time <= 100
        @@star_x += 1
        @@star_x += 1 if $player.skip == 1
        @@star_y += 1.73
        @@star_y += 1.73 if $player.skip == 1
      elsif @@time <= 200
        @@star_x -= 2
        @@star_x -= 2 if $player.skip == 1
        @@star_y -= 0.615 * 2
        @@star_y -= 0.615 * 2 if $player.skip == 1
      elsif @@time <= 300
        @@star_x += 2
        @@star_x += 2 if $player.skip == 1
      elsif @@time <= 400
        @@star_x -= 2
        @@star_x -= 2 if $player.skip == 1
        @@star_y += 0.615 * 2
        @@star_y += 0.615 * 2 if $player.skip == 1
      else
        @@star_x += 1
        @@star_x += 1 if $player.skip == 1
        @@star_y -= 1.73
        @@star_y -= 1.73 if $player.skip == 1
      end

      #表示
      x = @@star_x.floor
      y = @@star_y.floor
      Window.draw(x, y, @@star)
      Window.draw_font(220, 380, "占い中...", $font_40)
      @@time += 1
      @@time += 1 if $player.skip == 1
      if @@time >= 560
        @@sel = 0
        @@star_x = 300
        @@star_y = 50
        @@time = 1
        @@p_f = 17
      end
    when 19, 20, 21, 22, 23, 24 #売店
      @@h_b = Sprite.new(5, 5, Image.new(154, 94, C_WHITE))
      @@da_pl = Sprite.new(7, 7, Image.new(150, 90, C_BLACK))
      @@h_b4 = Sprite.new(5, 355, Image.new(590, 244, C_WHITE))
      @@b_b4 = Sprite.new(7, 357, Image.new(586, 240, C_BLACK))
      Sprite.draw([@@h_b, @@da_pl, @@h_b4, @@b_b4])
      Window.draw_font(7, 7, "#{$player.name}", $font_30)
      Window.draw_font(7, 37, "レベル: #{$player.lv}", $font_30)
      Window.draw_font(7, 67, "お金  : #{$player.money}", $font_30)
      if @@p_f == 20 || @@p_f == 21 || @@p_f == 23
        cnt = 0
        num = Item.can_num

        #スクロール
        if num > 17
          num = 17
          cnt = @@sel - 8
          if cnt < 0
            cnt = 0
          end
          if cnt + 18 > Item.can_num
            cnt = Item.can_num - 17
          end
        end

        #表示
        @@h_b5 = Sprite.new(160, 5, Image.new(174, num * 20 + 4, C_WHITE))
        @@b_b5 = Sprite.new(162, 7, Image.new(170, num * 20, C_BLACK))
        Sprite.draw([@@h_b5, @@b_b5])
        Window.draw_font(162, (@@sel - cnt) * 20 + 7, "◎", $font_20)
        num.times do |i|
          Window.draw_font(187, i * 20 + 7, "#{Item.menu[cnt]["name"]}", $font_20)
          cnt += 1
        end

        #ステータス表示
        str = [
          ["money", "heal", "atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree"],
          ["money", "damage"],
          ["money", "waza_size"]
        ]

        num = 0
        case(Item.menu[@@sel]["mode"])
        when 0
          if Item.menu[@@sel]["expr"] == nil
            str[0].size.times do |i|
              if Item.menu[@@sel][str[0][i]] != 0
                num += 1
              end
            end
          else
            num = 5
          end
        when 1
          num = 2
        when 2
          num = 1 + Item.menu[@@sel][str[2][1]]
        end
        @@h_b6 = Sprite.new(335, 5, Image.new(184, num * 20 + 4, C_WHITE))
        @@b_b6 = Sprite.new(337, 7, Image.new(180, num * 20, C_BLACK))
        Sprite.draw([@@h_b6, @@b_b6])
        
        s_j = [
          ["お金", "回復", "攻撃力", "防御力", "速度", "火キラー", "水キラー", "木キラー", "火耐性", "水耐性", "木耐性"],
          ["お金", "ダメージ"],
          ["お金", "技"]
        ]
        if Item.menu[@@sel]["expr"] == nil
          cnt = 0
          str[Item.menu[@@sel]["mode"]].size.times do |i|
            s = Item.menu[@@sel][str[Item.menu[@@sel]["mode"]][i]]
            ch = str[Item.menu[@@sel]["mode"]][i]
            if ch != "waza_size"
              if s != 0
                Window.draw_font(337, cnt * 20 + 7, "#{s_j[Item.menu[@@sel]["mode"]][i]}", $font_20)
                Window.draw_font(517 - "#{s}".size * 10, cnt * 20 + 7, "#{s}", $font_20)
                cnt += 1
              end
            else
              s.times do |i|
                Window.draw_font(337, cnt * 20 + 7, "技#{i + 1}: #{Item.menu[@@sel]["waza#{i}"]}", $font_20)
                cnt += 1
              end
            end
          end
        else
          Window.draw_font(337, 7, "お金", $font_20)
          Window.draw_font(517 - "#{Item.menu[@@sel]["money"]}".to_s.size * 10, 7, "#{Item.menu[@@sel]["money"]}", $font_20)
          Window.draw_font(337, 27, "#{Item.menu[@@sel]["expr"]}", $font_20)
        end

        if @@p_f == 21
          #ボード
          @@h_b6 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
          @@b_b6  = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
          Sprite.draw([@@h_b6, @@b_b6])
  
          #メッセージ
          Window.draw_font(187, 107, "購入しますか??", $font_30)
          Window.draw_font(187, 137, "   はい    いいえ", $font_30)
          Window.draw_font(187 + @@s * 90, 137, "◎", $font_30)
        end
        if @@p_f == 23
          #ボード
          @@h_b7 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
          @@b_b7 = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
          Sprite.draw([@@h_b7, @@b_b7])
          
          #メッセージ
          Window.draw_font(187, 107, "お金が足りません", $font_30)
        end
      end

      #コメント
      case(@@p_f)
      when 19
        Window.draw_font(7, 357, "へいらっしゃい", $font_20)
        Window.draw_font(7, 377, "名前もないただの店だよー", $font_20)
      when 20, 21, 23
        Window.draw_font(7, 357, "なにか買ってくかい?", $font_20)
      when 22
        Window.draw_font(7, 357, "毎度アリー、他にもいろいろ見てってやー", $font_20)
      when 24
        Window.draw_font(7, 357, "ありがとうございましたー", $font_20)
        Window.draw_font(7, 377, "また来てやー", $font_20)
      end
    when 25, 26, 27, 28, 29, 30, 31
      @@h_b = Sprite.new(5, 5, Image.new(154, 94, C_WHITE))
      @@da_pl = Sprite.new(7, 7, Image.new(150, 90, C_BLACK))
      @@h_b4 = Sprite.new(5, 355, Image.new(590, 244, C_WHITE))
      @@b_b4 = Sprite.new(7, 357, Image.new(586, 240, C_BLACK))
      Sprite.draw([@@h_b, @@da_pl, @@h_b4, @@b_b4])
      Window.draw_font(7, 7, "#{$player.name}", $font_30)
      Window.draw_font(7, 37, "レベル: #{$player.lv}", $font_30)
      Window.draw_font(7, 67, "お金  : #{$player.money}", $font_30)
      if @@p_f != 25 && @@p_f != 29 && @@p_f != 31
        #部位の表示
        @@h_b2 = Sprite.new(160, 5, Image.new(44, 184, C_WHITE))
        @@b_b2 = Sprite.new(162, 7, Image.new(40, 180, C_BLACK))
        Sprite.draw([@@h_b2, @@b_b2])
        Window.draw_font(182,  7, "頭      ",$font_20)
        Window.draw_font(182, 27, "腕      ",$font_20)
        Window.draw_font(182, 47, "剣      ",$font_20)
        Window.draw_font(182, 67, "盾      ",$font_20)
        Window.draw_font(182, 87, "鎧      ",$font_20)
        Window.draw_font(182, 107, "靴      ",$font_20)
        Window.draw_font(182, 127, "守      ",$font_20)
        Window.draw_font(182, 147, "眼      ",$font_20)
        Window.draw_font(182, 167, "耳      ",$font_20)
        Window.draw_font(162, @@sel * 20 + 7, "◎", $font_20)

        #武器の表示
        @@h_b3 = Sprite.new(205, 5, Image.new(194, Weapon.can_num(@@sel) * 20 + 4, C_WHITE))
        @@b_b3 = Sprite.new(207, 7, Image.new(190, Weapon.can_num(@@sel) * 20, C_BLACK))
        Sprite.draw([@@h_b3, @@b_b3])
        Weapon.can_num(@@sel).times do |i|
          Window.draw_font(227, i * 20 + 7, "#{Weapon.menu(@@sel)[i]["name"]}", $font_20)
        end
        if @@p_f == 27 || @@p_f == 28 || @@p_f == 30
          Window.draw_font(207, @@sos * 20 + 7, "◎", $font_20)

          str = ["money", "atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r"]
          num = 0
          str.size.times do |i|
            if Weapon.menu(@@sel)[@@sos][str[i]] != 0
              num += 1
            end
          end
          @@h_b4 = Sprite.new(395, 5, Image.new(184, num * 20 + 4, C_WHITE))
          @@b_b4 = Sprite.new(397, 7, Image.new(180, num * 20, C_BLACK))
          Sprite.draw([@@h_b4, @@b_b4])

          s_j = ["お金     ", "攻撃力   ", "防御力  ", "速度  ", "火キラー  ", "水キラー  ", "木キラー  ", "火耐性  ", "水耐性  ", "木耐性  ", "会心率  ", "回避率  "]
          cnt = 0
          str.size.times do |i|
            s = Weapon.menu(@@sel)[@@sos][str[i]]
            if s != 0
              Window.draw_font(397, cnt * 20 + 7, "#{s_j[i]}", $font_20)
              Window.draw_font(577 - "#{s}".size * 10, cnt * 20 + 7, "#{s}", $font_20)
              cnt += 1
            end
          end
        end
      end

      case(@@p_f)
      when 25
        Window.draw_font(7, 357, "よく来たな", $font_20)
        Window.draw_font(7, 377, "ここは、武器屋「武器屋」だ", $font_20)
      when 26, 27, 28, 30
        Window.draw_font(7, 357, "購入したい武器を選べ", $font_20)
      when 29
        Window.draw_font(7, 357, "分かった。この武器を譲ろう", $font_20)
      when 31
        Window.draw_font(7, 357, "では、行ってまいれ", $font_20)
        Window.draw_font(7, 377, "武運を祈る", $font_20)
      end

      if @@p_f == 28
        #ボード
        @@h_b6 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
        @@b_b6  = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
        Sprite.draw([@@h_b6, @@b_b6])

        #メッセージ
        Window.draw_font(187, 107, "購入しますか??", $font_30)
        Window.draw_font(187, 137, "   はい    いいえ", $font_30)
        Window.draw_font(187 + @@s * 90, 137, "◎", $font_30)
      end

      if @@p_f == 30
        #ボード
        @@h_b7 = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
        @@b_b7 = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
        Sprite.draw([@@h_b7, @@b_b7])
        
        #メッセージ
        Window.draw_font(187, 107, "お金が足りません", $font_30)
      end

    when 32
      #表示
      @@h_b = Sprite.new(5, 5, Image.new(154, 94, C_WHITE))
      @@da_pl = Sprite.new(7, 7, Image.new(150, 90, C_BLACK))
      @@h_b4 = Sprite.new(5, 355, Image.new(590, 244, C_WHITE))
      @@b_b4 = Sprite.new(7, 357, Image.new(586, 240, C_BLACK))
      Sprite.draw([@@h_b, @@da_pl, @@h_b4, @@b_b4])
      Window.draw_font(7, 7, "#{$player.name}", $font_30)
      Window.draw_font(7, 37, "レベル: #{$player.lv}", $font_30)
      Window.draw_font(7, 67, "お金  : #{$player.money}", $font_30)
      Window.draw_font(7, 357, "どのクエストに行きますか？", $font_20)
      
      @@h_b5 = Sprite.new(160, 5, Image.new(304, Quest_menu.can_num * 20 + 4, C_WHITE))
      @@b_b5 = Sprite.new(162, 7, Image.new(300, Quest_menu.can_num * 20, C_BLACK))
      Sprite.draw([@@h_b5, @@b_b5])
      Quest_menu.can_num.times do |i|
        Window.draw_font(182, 20 * i + 7, "#{Quest_menu.menu[i]}", $font_20)
      end
      Window.draw_font(162, @@sel * 20 + 7, "◎", $font_20)

    when 33
      @@time += 2

      @@board = Sprite.new(0, 0, Image.new(600, 600, [@@time, 0, 0, 0]))
      Sprite.draw(@@board)
      if @@time >= 255
        @@time = 1
        @@chenge = @@sel + 1
        @@chenge = 13 if @@chenge == 11
      end
    end

    if @@chenge != 0
      num = @@chenge
      @@p_f = 0
      @@sos = 0
      @@sel = 0
      @@re_f = 0
      @@x = 2
      @@y = 6
      @@der = 2
      @@chenge = 0
      return num
    else
      return @@chenge
    end
  end

  def self.chenge=(chenge)
    @@chenge = chenge
  end
end