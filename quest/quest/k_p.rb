require_relative '../../battle/rpg'
require_relative '../../battle/shooting'
require_relative '../../battle/fighting'
require_relative '../../chara_state/rpg_enemy'
require_relative '../../chara_state/shooting_enemy'
require_relative '../../chara_state/fighting_enemy'

class K_p
  @@map = [
    [4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,5],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,6]
  ]

  @@change = 7
  @@s_f = -1
  @@x = 1
  @@y = 17
  @@der = 2
  @@time = 0
  @@mission_num = 1
  @@go = 0
  @@sel = 0
  @@sos = 0
  @@con = 0
  @@e_f = 0
  

  #写真
  @@kp_floor = Image.load('image/kp_floor.png')
  @@red_coner = Image.load('image/red_coner.png')
  @@blue_coner = Image.load('image/blue_coner.png')
  @@black_migiue = Image.load('image/black_migiue.png')
  @@black_hidarisita = Image.load('image/black_hidarisita.png')
  @@sen_yoko = Image.load('image/sen_yoko.png')
  @@sen_sita = Image.load('image/sen_tate.png')
  @@ring = Image.load('image/ring.png').set_color_key(C_WHITE)
  @@bake_fire = Image.load('image/bake_fire.png').set_color_key(C_WHITE)
  @@bake_water = Image.load('image/bake_water.png').set_color_key(C_WHITE)
  @@bake_tree = Image.load('image/bake_tree.png').set_color_key(C_WHITE)
  @@ring_imgs = [
    Image.load('image/ring0-0.png').set_color_key(C_WHITE),
    Image.load('image/ring0-1.png').set_color_key(C_WHITE),
    Image.load('image/ring1-0.png').set_color_key(C_WHITE),
    Image.load('image/ring1-1.png').set_color_key(C_WHITE)
  ]
  @@b_f_imgs = [
    Image.load('image/bake_fire0-0.png').set_color_key(C_WHITE),
    Image.load('image/bake_fire0-1.png').set_color_key(C_WHITE),
    Image.load('image/bake_fire1-0.png').set_color_key(C_WHITE),
    Image.load('image/bake_fire1-1.png').set_color_key(C_WHITE)
  ]
  @@b_w_imgs = [
    Image.load('image/bake_water0-0.png').set_color_key(C_WHITE),
    Image.load('image/bake_water0-1.png').set_color_key(C_WHITE),
    Image.load('image/bake_water1-0.png').set_color_key(C_WHITE),
    Image.load('image/bake_water1-1.png').set_color_key(C_WHITE)
  ]
  @@b_t_imgs = [
    Image.load('image/bake_tree0-0.png').set_color_key(C_WHITE),
    Image.load('image/bake_tree0-1.png').set_color_key(C_WHITE),
    Image.load('image/bake_tree1-0.png').set_color_key(C_WHITE),
    Image.load('image/bake_tree1-1.png').set_color_key(C_WHITE)
  ]

  def self.ple_move
    if Input.key_push?(K_W)
      case(@@map[@@y - 1][@@x])
      when 0
        @@y -= 1
      when 7
        @@ring_data = Fighting_enemy.new(30, 30, 1, 8, 5, 6, 0, 400, 1, 20, 35)
        @@s_f = 1
        @@go = 0
      when 8
        @@bake_fire_data = Fighting_enemy.new(40, 40, 1, 25, 5, 19, 0, 300, 1, 40, 50)
        @@s_f = 1
        @@go = 1
      when 9
        @@bake_water_data = Fighting_enemy.new(50, 50, 2, 20, 8, 25, 0, 250, 2, 40, 50)
        @@s_f = 1
        @@go = 2
      when 10
        @@bake_tree_data = Fighting_enemy.new(60, 60, 1, 30, 1, 30, 0, 300, 3, 40, 50)
        @@s_f = 1
        @@go = 3
      end
      @@der = 0
    end
    if Input.key_push?(K_A)
      case(@@map[@@y][@@x - 1])
      when 0
        @@x -= 1
      when 7
        @@ring_data = Fighting_enemy.new(30, 30, 1, 8, 5, 6, 0, 400, 1, 20, 35)
        @@s_f = 1
        @@go = 0
      when 8
        @@bake_fire_data = Fighting_enemy.new(40, 40, 1, 25, 5, 19, 0, 300, 1, 40, 50)
        @@s_f = 1
        @@go = 1
      when 9
        @@bake_water_data = Fighting_enemy.new(50, 50, 2, 20, 8, 25, 0, 250, 2, 40, 50)
        @@s_f = 1
        @@go = 2
      when 10
        @@bake_tree_data = Fighting_enemy.new(60, 60, 1, 30, 1, 30, 0, 300, 3, 40, 50)
        @@s_f = 1
        @@go = 3
      end
      @@der = 3
    end
    if Input.key_push?(K_S)
      case(@@map[@@y + 1][@@x])
      when 0
        @@y += 1
      when 7
        @@ring_data = Fighting_enemy.new(30, 30, 1, 8, 5, 6, 0, 400, 1, 20, 35)
        @@s_f = 1
        @@go = 0
      when 8
        @@bake_fire_data = Fighting_enemy.new(40, 40, 1, 25, 5, 19, 0, 300, 1, 40, 50)
        @@s_f = 1
        @@go = 1
      when 9
        @@bake_water_data = Fighting_enemy.new(50, 50, 2, 20, 8, 25, 0, 250, 2, 40, 50)
        @@s_f = 1
        @@go = 2
      when 10
        @@bake_tree_data = Fighting_enemy.new(60, 60, 1, 30, 1, 30, 0, 300, 3, 40, 50)
        @@s_f = 1
        @@go = 3
      end
      @@der = 2
    end
    if Input.key_push?(K_D)
      case(@@map[@@y][@@x + 1])
      when 0
        @@x += 1
      when 7
        @@ring_data = Fighting_enemy.new(30, 30, 1, 8, 5, 6, 0, 400, 1, 20, 35)
        @@s_f = 1
        @@go = 0
      when 8
        @@bake_fire_data = Fighting_enemy.new(40, 40, 1, 25, 5, 19, 0, 300, 1, 40, 50)
        @@s_f = 1
        @@go = 1
      when 9
        @@bake_water_data = Fighting_enemy.new(50, 50, 2, 20, 8, 25, 0, 250, 2, 40, 50)
        @@s_f = 1
        @@go = 2
      when 10
        @@bake_tree_data = Fighting_enemy.new(60, 60, 1, 30, 1, 30, 0, 300, 3, 40, 50)
        @@s_f = 1
        @@go = 3
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
      K_p.ple_move
    when 7
      K_p.menu_sel
    when 8
      K_p.item_sel
    when 9
      K_p.con_sel
    when 10, 11
      K_p.wait
    end
  end


  def self.check_mission
    case(@@mission_num)
    when 2
      if @@e_f == 3
        @@change = 12
      end
    end
  end

  def self.draw
    K_p.check_mission

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
            Window.draw(x_i * 75, y_i * 75, @@kp_floor)
          when 1
            Window.draw(x_i * 75, y_i * 75, @@sen_sita)
          when 2
            Window.draw(x_i * 75, y_i * 75, @@sen_yoko)
          when 3
            Window.draw(x_i * 75, y_i * 75, @@red_coner)
          when 4
            Window.draw(x_i * 75, y_i * 75, @@black_migiue)
          when 5
            Window.draw(x_i * 75, y_i * 75, @@blue_coner)
          when 6
            Window.draw(x_i * 75, y_i * 75, @@black_hidarisita)
          when 7
            Window.draw(x_i * 75, y_i * 75, @@kp_floor)
            Window.draw(x_i * 75, y_i * 75, @@ring)
          when 8
            Window.draw(x_i * 75, y_i * 75, @@kp_floor)
            Window.draw(x_i * 75, y_i * 75, @@bake_fire)
          when 9
            Window.draw(x_i * 75, y_i * 75, @@kp_floor)
            Window.draw(x_i * 75, y_i * 75, @@bake_water)
          when 10
            Window.draw(x_i * 75, y_i * 75, @@kp_floor)
            Window.draw(x_i * 75, y_i * 75, @@bake_tree)
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
        Window.draw_font(282, 7, "ミッション: 1/2 見えてる敵を倒せ 0/1", $font_20)
      when 2
        Window.draw_font(282, 7, "ミッションFINAL! BOSS3体を倒せ! #{@@e_f}/3", $font_20)
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
          end
          @@time = 0
        end
      end
    when 2
      #格闘 動くリング
      num, @@ring_data = Fighting.draw("動くリング", @@ring_imgs, @@ring_data)

      if num == 3
        @@change = 11
      end
      if num == 2 || num == 1
        @@s_f = 0
        if num == 2
          @@mission_num = 2
          @@map[8][8] = 0
          @@map[1][1] = 8
          @@map[1][15] = 9
          @@map[17][15] = 10
        end
      end
    when 3
      #BOSS1 格闘 火の化け物
      num, @@bake_fire_data = Fighting.draw("火の化け物", @@b_f_imgs, @@bake_fire_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@e_f += 1
          if @@e_f == 3
            $player.result_add(6)
            @@change = 12
          end
          @@map[1][1] = 0
        end
      end
    when 4
      #BOSS2 格闘 水の化け物
      num, @@bake_water_data = Fighting.draw("水の化け物", @@b_w_imgs, @@bake_water_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@map[1][15] = 0
        @@e_f += 1
        if @@e_f == 3
          $player.result_add(6)
          @@change = 12
        end
        @@s_f = 0
      end
    when 5
      #BOSS3 格闘 木の化け物
      num, @@bake_tree_data = Fighting.draw("木の化け物", @@b_t_imgs, @@bake_tree_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        @@e_f += 1
        if @@e_f == 3
          $player.result_add(6)
          @@change = 12
        end
        @@map[17][15] = 0
      end
    end

    if @@change != 7
      @@map = [
      [4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,5],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
      [3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,6]
    ]
  
    num = @@change
    @@change = 7
    @@s_f = -1
    @@x = 1
    @@y = 17
    @@der = 2
    @@time = 0
    @@mission_num = 1
    @@go = 0
    @@sel = 0
    @@sos = 0
    @@con = 0
    @@e_f = 0
    return num
    end

    return @@change
  end
end