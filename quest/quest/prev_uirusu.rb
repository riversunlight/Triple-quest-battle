require_relative '../../battle/rpg'
require_relative '../../battle/shooting'
require_relative '../../battle/fighting'
require_relative '../../chara_state/rpg_enemy'
require_relative '../../chara_state/shooting_enemy'
require_relative '../../chara_state/fighting_enemy'

class Prev_uirusu
  @@map = [
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,2,0,0,0,0,0,0,2,0,0,0,0,0,0,2,1],
    [1,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1],
    [1,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,1],
    [1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,1],
    [1,0,1,1,1,0,0,1,0,0,0,1,0,0,0,0,1],
    [1,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1],
    [1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1],
    [1,0,0,0,1,0,2,0,0,1,0,0,0,0,0,0,1],
    [1,0,0,0,1,0,0,0,2,1,0,1,0,1,1,0,1],
    [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,1,0,0,0,2,1,0,0,0,0,1],
    [1,2,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
    [1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,1,2,0,1,0,2,1],
    [1,0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,1],
    [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
  ]

  @@change = 8
  @@s_f = -1
  @@x = 1
  @@y = 17
  @@der = 2
  @@time = 0
  @@cnt_m = 0
  @@mission_num = 1
  @@go = 0
  @@before_meet = 0
  @@sel = 0
  @@sos = 0
  @@con = 0

  
  #写真
  @@pu_floor = Image.load('image/soil.png')
  @@tree = Image.load('image/tree.png')
  @@medicine = Image.load('image/medicine.png').set_color_key(C_WHITE)
  @@kosen_uirusu = Image.load('image/kosen_uirusu.png').set_color_key(C_WHITE)
  @@rorona_uirusu = Image.load('image/rorona_uirusu.png').set_color_key(C_WHITE)
  @@kosen_uirusu_max = Image.load('image/kosen_uirusu_max.png').set_color_key(C_WHITE)
  @@ku_kakutou = [
    Image.load('image/kosen_uirusu0-0.png').set_color_key(C_WHITE),
    Image.load('image/kosen_uirusu0-1.png').set_color_key(C_WHITE),
    Image.load('image/kosen_uirusu1-0.png').set_color_key(C_WHITE),
    Image.load('image/kosen_uirusu1-1.png').set_color_key(C_WHITE)
  ]
  @@ru_kakutou = [
    Image.load('image/rorona_uirusu0-0.png').set_color_key(C_WHITE),
    Image.load('image/rorona_uirusu0-1.png').set_color_key(C_WHITE),
    Image.load('image/rorona_uirusu1-0.png').set_color_key(C_WHITE),
    Image.load('image/rorona_uirusu1-1.png').set_color_key(C_WHITE)
  ]

  def self.ple_move
    if Input.key_push?(K_W)
      case(@@map[@@y - 1][@@x])
      when 0
        @@y -= 1
        if @@mission_num == 1
          @@before_meet += 1
          Prev_uirusu.ran_meet  
        end
      when 2
        @@map[@@y - 1][@@x] = 0
        @@y -= 1
        @@cnt_m += 1
      when 3
        @@kosen_max_data = Rpg_enemy.new(40, 40, 20, 20, 10, 15, 40, 15, 1, [
          {"name" => "ホ〇にする", "mp" => 9, "atack" => 25, "speed" => 2}
        ], 30, 45)
        @@go = 0
        @@s_f = 1
      end
      @@der = 0
    end
    if Input.key_push?(K_A)
      case(@@map[@@y][@@x - 1])
      when 0
        @@x -= 1
        if @@mission_num == 1
          @@before_meet += 1
          Prev_uirusu.ran_meet  
        end
      when 2
        @@map[@@y][@@x - 1] = 0
        @@x -= 1
        @@cnt_m += 1
      when 3
        @@kosen_max_data = Rpg_enemy.new(40, 40, 20, 20, 10, 15, 40, 15, 1, [
          {"name" => "ホ〇にする", "mp" => 9, "atack" => 25, "speed" => 2}
        ], 30, 45)
        @@go = 0
        @@s_f = 1
      end
      @@der = 3
    end
    if Input.key_push?(K_S)
      case(@@map[@@y + 1][@@x])
      when 0
        @@y += 1
        if @@mission_num == 1
          @@before_meet += 1
          Prev_uirusu.ran_meet  
        end
      when 2
        @@map[@@y + 1][@@x] = 0
        @@y += 1
        @@cnt_m += 1
      when 3
        @@kosen_max_data = Rpg_enemy.new(40, 40, 20, 20, 10, 15, 40, 15, 1, [
          {"name" => "ホ〇にする", "mp" => 9, "atack" => 25, "speed" => 2}
        ], 30, 45)
        @@go = 0
        @@s_f = 1
      end
      @@der = 2
    end
    if Input.key_push?(K_D)
      case(@@map[@@y][@@x + 1])
      when 0
        @@x += 1
        if @@mission_num == 1
          @@before_meet += 1
          Prev_uirusu.ran_meet  
        end
      when 2
        @@map[@@y][@@x + 1] = 0
        @@x += 1
        @@cnt_m += 1
      when 3
        @@kosen_max_data = Rpg_enemy.new(40, 40, 20, 20, 10, 15, 40, 15, 1, [
          {"name" => "ホ〇にする", "mp" => 9, "atack" => 25, "speed" => 2}
        ], 30, 45)
        @@go = 0
        @@s_f = 1
      end
      @@der = 1
    end
    
    if Input.key_push?(K_T)
      @@s_f = 7
    end
  end

  def self.item_sel
    if Input.key_push?(K_W)
      @@sos -= 1
    end
    if Input.key_push?(K_S)
      @@sos += 1
    end
    cnt = 0
    $player.item.size.times do |i|
      if $player.item[i] != 0
        cnt += 1
      end
    end
    @@sos = (@@sos + cnt) % cnt

    if Input.key_push?(K_T) || Input.key_push?(K_A) || Input.key_push?(K_ESCAPE)
      @@s_f = 7
      @@sos = 0
    end
    if Input.key_push?(K_RETURN)
      @@s_f = 9
    end
  end

  def self.ran_meet
    if @@before_meet >= 3
      srand(Time.now.to_i)
      r = rand(100)
      if r <= 10
        @@s_f = 1
        @@go = 1
        @@rpg_ku = Rpg_enemy.new(30, 30, 50, 50, 15, 20, 15, 9, 1, [
          {"name" => "圧倒的感染力", "mp" => 4, "atack" => 20, "speed" => 6}
        ], 20, 15)
      elsif r <= 20
        @@s_f = 1
        @@go = 2
        @@fighting_ku = Fighting_enemy.new(40, 40, 1, 20, 5, 20, 0, 300, 1, 20, 15)
      elsif r <= 30
        @@s_f = 1
        @@go = 3
        @@rpg_ru = Rpg_enemy.new(40, 40, 10, 10, 5, 20, 15, 8, 2, [
          {"name" => "無症状感染", "mp" => 4, "atack" => 10, "speed" => 6},
          {"name" => "ロロナ肺炎", "mp" => 10, "atack" => 40, "speed" => 3}
        ], 20, 15)
      elsif r <= 40
        @@s_f = 1
        @@go = 4
        @@fighting_ru = Fighting_enemy.new(30, 30, 2, 15, 20, 15, 0, 150, 2, 20, 15)
      end
      @@before_meet = 0
    end
  end

  def self.menu_sel
    if Input.key_push?(K_W)
      @@sel -= 1
    end
    if Input.key_push?(K_S)
      @@sel += 1
    end
    @@sel = (@@sel + 2) % 2

    if Input.key_push?(K_T) || Input.key_push?(K_A) || Input.key_push?(K_ESCAPE)
      @@s_f = 0
      @@sel = 0
    end
    if Input.key_push?(K_RETURN) && @@sel == 1
      cnt = 0
      $player.item.size.times do |i|
        if $player.item[i] != 0
          cnt += 1
        end
      end
      @@s_f = 8 if cnt != 0
    end
  end

  def self.wait
    if Op_update.AnyKey_push? || Input.key_push?(K_RETURN)
      case(@@s_f)
      when 10, 11
        if @@s_f == 10
          can_num = []
          $player.item.size.times do |i|
            if $player.item[i] != 0
              can_num.push(i)
            end
          end
          $player.item_take(can_num[@@sos])
          
          @@sos -= 1
          if $player.item[can_num[@@sos + 1]] != 0
            @@sos += 1
          end
          if @@sos < 0
            @@sos = 0
          end
          num = 0
          $player.item.size.times do |i|
            if $player.item[i] != 0
              num += 1
            end
          end
          if num == 0
            @@s_f = 7
            @@sos = 0
          else
            @@s_f = 8
          end
        else
          @@s_f = 8
        end
      end
    end
  end

  def self.con_sel
    if Input.key_push?(K_A)
      @@con -= 1
    end
    if Input.key_push?(K_D)
      @@con += 1
    end
    @@con = (@@con + 2) % 2

    if Input.key_push?(K_RETURN)
      can_num = []
      $player.item.size.times do |i|
        if $player.item[i] != 0
          can_num.push(i)
        end
      end
      num = Item.use_item_park(can_num[@@sos])
      if num == 0
        @@s_f = 10
      else
        @@s_f = 11
      end
    end
  end

  def self.move
    case(@@s_f)
    when 0
      Prev_uirusu.ple_move
    when 7
      Prev_uirusu.menu_sel
    when 8
      Prev_uirusu.item_sel
    when 9
      Prev_uirusu.con_sel
    when 10, 11
      Prev_uirusu.wait
    end
  end


  def self.check_mission
    case(@@mission_num)
    when 1
      if @@cnt_m == 9
        @@mission_num = 2
        @@map[17][15] = 3
      end
    end
  end

  def self.draw
    Prev_uirusu.check_mission

    case(@@s_f)
    when 0, 1, -1, 7 .. 12
      nx = @@x - 3
      nx = 0 if nx <= 0
      nx = @@map[0].size - 8 if nx + 8 >= @@map[0].size
      ny = @@y - 3
      ny = 0 if ny <= 0
      ny = @@map.size - 8 if ny + 8 >= @@map.size
  
      y_i = 0
      for i in ny .. ny + 7
        x_i = 0
        for j in nx .. nx + 7
          case(@@map[i][j])
          when 0
            Window.draw(x_i * 75, y_i * 75, @@pu_floor)
          when 1
            Window.draw(x_i * 75, y_i * 75, @@tree)
          when 2
            Window.draw(x_i * 75, y_i * 75, @@pu_floor)
            Window.draw(x_i * 75, y_i * 75, @@medicine)
          when 3
            Window.draw(x_i * 75, y_i * 75, @@pu_floor)
            Window.draw(x_i * 75, y_i * 75, @@kosen_uirusu_max)
          end
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
            Window.draw(x_i * 75, y_i * 75, image)
          end
          x_i += 1
        end
        y_i += 1
      end

      #簡易ステータス表示
      @@h_b = Sprite.new(5, 5, Image.new(304, 34, C_WHITE))
      @@b_b = Sprite.new(7, 7, Image.new(300, 30, C_BLACK))
      Sprite.draw([@@h_b, @@b_b])
      Window.draw_font(7, 7, "#{$player.name} HP: #{$player.hp}/#{$player.hp_max} LV:#{$player.lv}", $font_30)

      #ミッション表示
      @@h_b1 = Sprite.new(280, 5, Image.new(314, 24, C_WHITE))
      @@b_b1 = Sprite.new(282, 7, Image.new(310, 20, C_BLACK))
      Sprite.draw([@@h_b1, @@b_b1])
      case(@@mission_num)
      when 1
        Window.draw_font(282, 7, "ミッション: 1/2 薬を集めろ #{@@cnt_m}/9", $font_20)
      when 2
        Window.draw_font(282, 7, "ミッション: FINAL ボスを倒せ!!!", $font_20)
      end

      if @@s_f >= 7 && @@s_f <= 12
        @@h_b = Sprite.new(5, 39, Image.new(184, 64, C_WHITE))
        @@b_b = Sprite.new(7, 41, Image.new(180, 60, C_BLACK))
        Sprite.draw([@@h_b, @@b_b])
  
        Window.draw_font(37, 41, "ステータス", $font_30)
        Window.draw_font(37, 71, "アイテム", $font_30)
        Window.draw_font(7, @@sel * 30 + 41, "◎", $font_30)
  
        case(@@sel)
        when 0
          @@h_b = Sprite.new(190, 39, Image.new(404, 364, C_WHITE))
          @@b_b = Sprite.new(192, 41, Image.new(400, 360, C_BLACK))
          Sprite.draw([@@h_b, @@b_b])

          str = ["atack", "speed", "block", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r", "r_mp_max", "r_mp_heal", "boal_s", "b_mp_max", "b_mp_heal", "jump", "stop"]
          s_j = ["攻撃力", "速度", "防御力", "火キラー", "水キラー", "木キラー", "火耐性", "水耐性", "木耐性", "会心率", "回避率", "RPG MP", "RPG MP回復量", "ボール速度", "シューティングMP", "シューティングMP回復量", "格闘 ジャンプ", "格闘 硬直"]
          str.size.times do |i|
            Window.draw_font(192, 41 + 20 * i, "#{s_j[i]}", $font_20)
            num = 1
            if $player.state[str[i]] != 0
              num = Math.log10($player.state[str[i]]).floor + 1
            end
            Window.draw_font(592 - num * 10, 41 + 20 * i, "#{$player.state[str[i]]}", $font_20)
          end
        when 1
          cnt = 0
          $player.item.size.times do |i|
            if $player.item[i] != 0
              cnt += 1
            end
          end
          @@h_b = Sprite.new(190, 39, Image.new(204, [cnt, 1].max * 20 + 4, C_WHITE))
          @@b_b = Sprite.new(192, 41, Image.new(200, [cnt, 1].max * 20, C_BLACK))
          Sprite.draw([@@h_b, @@b_b])

          cnt = 0
          $player.item.size.times do |i|
            if $player.item[i] != 0
              Window.draw_font(212, 20 * cnt + 41, "#{Item.menu[i]["name"]}", $font_20)
              num = 0
              if $player.item[i] != 0
                num = Math.log10($player.item[i]).floor
              end
              Window.draw_font(342 - num * 10, 20 * cnt + 41, "#{$player.item[i]}個", $font_20)
              cnt += 1
            end
          end
          if cnt == 0
            Window.draw_font(192, 41, "NO ITEMS", $font_20)
          end
          Window.draw_font(192, @@sos * 20 + 41, "◎", $font_20) if @@s_f >= 8
          
          if @@s_f >= 8
            can_num = []
            $player.item.size.times do |i|
              if $player.item[i] != 0
                can_num.push(i)
              end
            end
            num = 0
            str = [
              ["heal", "atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree"],
              ["waza_size"],
              ["damage"]
            ]
            s_j = ["回復", "攻撃力", "防御力", "速度", "火キラー", "水キラー", "木キラー", "火耐性", "水耐性", "木耐性"]
            case(Item.menu[can_num[@@sos]]["mode"])
            when 0
              str[0].size.times do |i|
                if Item.menu[can_num[@@sos]][str[0][i]] != 0
                  num += 1
                end
              end
            when 2
              num = Item.menu[can_num[@@sos]]["waza_size"]
            when 1
              num = 2
            end
            h_b = Sprite.new(395, 39, Image.new(154, num * 20 + 4, C_WHITE))
            b_b = Sprite.new(397, 41, Image.new(150, num * 20, C_BLACK))
            Sprite.draw([h_b, b_b])
  
            case(Item.menu[can_num[@@sos]]["mode"])
            when 0
              cnt = 0
              str[0].size.times do |i|
                if Item.menu[can_num[@@sos]][str[0][i]] != 0
                  Window.draw_font(395, cnt * 20 + 41, "#{s_j[i]}", $font_20)
                  num = 0
                  if Item.menu[can_num[@@sos]][str[0][i]] != 0
                    num = Math.log10(Item.menu[can_num[@@sos]][str[0][i]]).floor
                  end
                  Window.draw_font(537 - num * 10, cnt * 20 + 41, "#{Item.menu[can_num[@@sos]][str[0][i]]}", $font_20)
                  cnt += 1
                end
              end
            when 2
              num.times do |i|
                Window.draw_font(395, i * 20 + 41, "技#{i + 1}:#{Item.menu[can_num[@@sos]]["waza#{i}"]}", $font_20)
              end
            when 1
              Window.draw_font(395, 41, "RPG専用", $font_20)
              Window.draw_font(395, 61, "ダメージ", $font_20)
              Window.draw_font(537 - Math.log10(Item.menu[can_num[@@sos]][str[2][0]]).floor * 10, 61, "#{Item.menu[can_num[@@sos]]["damage"]}", $font_20)
            end
          end


          if @@s_f >= 9
            #ボード
            @@h_b = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
            @@b_b = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
            Sprite.draw([@@h_b, @@b_b])
            
            #メッセージ
            Window.draw_font(187, 107, "使いますか?", $font_30)
            Window.draw_font(187, 137, "   はい    いいえ", $font_30)
            Window.draw_font(187 + @@con * 90, 137, "◎", $font_30)
            if @@s_f == 11
              @@h_b = Sprite.new(185, 125, Image.new(260, 40, C_WHITE))
              @@b_b = Sprite.new(187, 127, Image.new(256, 36, C_BLACK))
              Sprite.draw([@@h_b, @@b_b])

              Window.draw_font(187, 127, "使用不可!", $font_30)
            elsif @@s_f == 10
              @@h_b = Sprite.new(175, 125, Image.new(280, 40, C_WHITE))
              @@b_b = Sprite.new(177, 127, Image.new(276, 36, C_BLACK))
              Sprite.draw([@@h_b, @@b_b])

              Window.draw_font(177, 127, "使用しました", $font_30)
            end
          end
        end
      end

      case(@@s_f)
      when -1
        @@time += 1
  
        image = Sprite.new(0, 0, Image.new(600, 600, [255 - @@time, 0, 0, 0]))
        Sprite.draw(image)
        if @@time >= 255
          @@time = 0
          @@s_f = 0
        end
      when 1
        @@time += 10
        @@b_board1 = Sprite.new(0, 0, Image.new(600, @@time, C_BLACK))
        @@b_board2 = Sprite.new(0, 600 - @@time, Image.new(600, @@time, C_BLACK))
        Sprite.draw([@@b_board1, @@b_board2])
  
        if @@time >= 300
          case(@@go)
          when 0
            @@s_f = 2
          when 1
            @@s_f = 3
          when 2
            @@s_f = 4
          when 3
            @@s_f = 5
          when 4
            @@s_f = 6
          end
          @@time = 0
        end
      end
    when 2
      #BOSS RPG 高専病LV.MAX
      num, @@kosen_max_data = Rpg.draw(@@kosen_uirusu_max, "高専病LV.MAX", @@kosen_max_data)

      if num == 3
        @@change = 11
      end
      if num == 2 || num == 1
        @@s_f = 0
        if num == 2
          $player.result_add(7)
          @@change = 12
        end
      end
    when 3
      #RPG　高専病ウイルス
      num, @@rpg_ku = Rpg.draw(@@kosen_uirusu, "高専病ウイルス",  @@rpg_ku)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        if num == 2
          @@s_f = 0          
        end
      end
    when 4
      #格闘　高専病ウイルス
      num, @@fighting_ku = Fighting.draw("高専病ウイルス", @@ku_kakutou, @@fighting_ku)

      if num == 3
        @@change = 11
      end
      if num == 2
        @@s_f = 0
      end
    when 5
      #RPG ロロナウイルス
      num, @@rpg_ru = Rpg.draw(@@rorona_uirusu, "ロロナウイルス", @@rpg_ru)

      if num == 3
        @@change = 11
      end
      if num == 2
        @@s_f = 0
      end
    when 6
      #格闘 ロロナウイルス
      num, @@fighting_ru = Fighting.draw("ロロナウイルス", @@ru_kakutou, @@fighting_ru)

      if num == 3
        @@change = 11
      end
      if num == 2
        @@s_f = 0
      end
    end

    if @@change != 8
      @@map = [
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,2,0,0,0,0,0,0,2,0,0,0,0,0,0,2,1],
        [1,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1],
        [1,0,0,1,0,0,0,1,0,0,1,0,0,1,0,0,1],
        [1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,1],
        [1,0,1,1,1,0,0,1,0,0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1],
        [1,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,1],
        [1,0,0,0,1,0,2,0,0,1,0,0,0,0,0,0,1],
        [1,0,0,0,1,0,0,0,2,1,0,1,0,1,1,0,1],
        [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,1,0,0,0,2,1,0,0,0,0,1],
        [1,2,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1],
        [1,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,1,2,0,1,0,2,1],
        [1,0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,1],
        [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
      ]
      
      num = @@change
      @@change = 8
      @@s_f = -1
      @@x = 1
      @@y = 17
      @@der = 2
      @@time = 0
      @@cnt_m = 0
      @@mission_num = 1
      @@go = 0
      @@before_meet = 0
      @@sel = 0
      @@sos = 0
      @@con = 0
      return num
    end

    return @@change
  end
end