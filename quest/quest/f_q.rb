require_relative '../../battle/rpg'
require_relative '../../battle/shooting'
require_relative '../../battle/fighting'
require_relative '../../chara_state/rpg_enemy'
require_relative '../../chara_state/shooting_enemy'
require_relative '../../chara_state/fighting_enemy'

class F_q
  #マップ情報 0 => 道 1 => 木 2 => 敵(RPG) 3 => 敵(シューティング) 4 => 敵(格闘) 5 => ボス(最初は非表示)
  @@map = [
    [1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,2,0,0,0,1,0,0,0,0,1],
    [1,0,0,0,0,0,0,1,0,0,3,0,1],
    [1,1,0,1,0,1,0,1,0,0,0,0,1],
    [1,0,0,0,0,0,0,1,1,1,1,1,1],
    [1,0,1,0,1,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,1,0,0,0,0,0,1],
    [1,0,0,0,0,0,1,0,0,0,0,0,1],
    [1,0,0,0,0,0,1,0,0,4,0,0,1],
    [1,0,0,0,0,0,1,0,0,0,0,0,1],
    [1,0,0,0,0,0,1,0,0,0,0,0,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1]
  ]

  @@x = 1
  @@y = 11
  @@s_f = -1
  @@der = 2
  @@e_f = 0
  @@time = 0
  @@mission_max = 2
  @@mission_num = 1
  @@go = -1
  @@chenge = 1
  @@sel = 0
  @@sos = 0
  @@con = 0

  #写真
  @@soil = Image.load('image/soil.png')
  @@tree = Image.load('image/tree.png')
  @@faifai = Image.load('image/faifai.png')         #ファイファイ
  @@w_keshin = [
    Image.load('image/water_keshin0.png'), #水の化身
    Image.load('image/water_keshin1.png'), #水の化身
    Image.load('image/water_keshin2.png'), #水の化身
    Image.load('image/water_keshin3.png'), #水の化身
  ]
  @@leaf_taro = Image.load('image/leaf_taro.png')   #葉太郎
  @@hatarou = [
    Image.load('image/hataro0-0.png').set_color_key(C_WHITE),
    Image.load('image/hataro0-1.png').set_color_key(C_WHITE),
    Image.load('image/hataro1-0.png').set_color_key(C_WHITE),
    Image.load('image/hataro1-1.png').set_color_key(C_WHITE)
  ]
  @@bossun = Image.load('image/bossun.png').set_color_key(C_WHITE)

  #透明化
  @@faifai.set_color_key(C_WHITE)
  4.times do |i|
    @@w_keshin[i].set_color_key(C_WHITE)
  end
  @@leaf_taro.set_color_key(C_WHITE)

  def self.ple_move
    if Input.key_push?(K_W)
      case(@@map[@@y - 1][@@x])
      when 0
        @@y -= 1
      when 2
        @@s_f = 1
        @@go = 0
        @@faifai_data = Rpg_enemy.new(10, 10,  8, 8, 5, 0, 4, 4, 1, [
          {"name" => "炙る", "mp" => 4, "atack" => 0, "speed" => 1},
          {"name" => "180度に熱する", "mp" => 6, "atack" => 3, "speed" => 2},
        ],
        4, 7
        )
      when 3
        @@s_f = 1
        @@go = 1
        @@w_keshin_data = Shooting_enemy.new(20, 20, 10, 10, 4, 3, 1, 0, 3, 300, 2, 0, 4, 7)
      when 4
        @@go = 2
        @@hatarou_data = Fighting_enemy.new(15, 15, 1, 3, 4, 0, 0, 400, 3, 4, 7)
        @@s_f = 1
      when 5
        @@s_f = 1
        @@go = 3
        @@bossun_data = Rpg_enemy.new(15, 15, 10, 10, 7, 1, 8, 3, 1, [
          {"name" => "白目", "mp" => 5, "atack" => 0, "speed" => 8},
          {"name" => "ボス(雑魚)の意地", "mp" => 10, "atack" => 5, "speed" => 0}
        ],
        10, 21
        )
      end

      @@der = 0
    end
    if Input.key_push?(K_A)
      case(@@map[@@y][@@x - 1])
      when 0
        @@x -= 1
      when 2
        @@s_f = 1
        @@go = 0
        @@faifai_data = Rpg_enemy.new(10, 10,  8, 8, 5, 0, 4, 4, 1, [
          {"name" => "炙る", "mp" => 4, "atack" => 0, "speed" => 1},
          {"name" => "180度に熱する", "mp" => 6, "atack" => 3, "speed" => 2},
        ],
        4, 7)
      when 3
        @@s_f = 1
        @@go = 1
        @@w_keshin_data = Shooting_enemy.new(20, 20, 10, 10, 4, 3, 1, 0, 3, 300, 2, 0, 4, 7)
      when 4
        @@go = 2
        @@hatarou_data = Fighting_enemy.new(15, 15, 1, 3, 4, 0, 0, 400, 3, 4, 7)
        @@s_f = 1
      when 5
        @@s_f = 1
        @@go = 3
        @@bossun_data = Rpg_enemy.new(15, 15, 10, 10, 7, 1, 8, 3, 1, [
          {"name" => "白目", "mp" => 5, "atack" => 0, "speed" => 8},
          {"name" => "ボス(雑魚)の意地", "mp" => 10, "atack" => 5, "speed" => 0}
        ],
        10, 21
        )
      end

      @@der = 3
    end
    if Input.key_push?(K_S)
      case(@@map[@@y + 1][@@x])
      when 0
        @@y += 1
      when 2
        @@s_f = 1
        @@go = 0
        @@faifai_data = Rpg_enemy.new(10, 10,  8, 8, 5, 0,4, 4, 1, [
          {"name" => "炙る", "mp" => 4, "atack" => 0, "speed" => 1},
          {"name" => "180度に熱する", "mp" => 6, "atack" => 3, "speed" => 2},
        ],
        4, 7)
      when 3
        @@s_f = 1
        @@go = 1
        @@w_keshin_data = Shooting_enemy.new(20, 20, 10, 10, 4, 3, 1, 0, 3, 300, 2, 0, 4, 7)
      when 4
        @@s_f = 1
        @@hatarou_data = Fighting_enemy.new(15, 15, 1, 3, 4, 0, 0, 400, 3, 4, 7)
        @@go = 2
      when 5
        @@s_f = 1
        @@go = 3
        @@bossun_data = Rpg_enemy.new(15, 15, 10, 10, 7, 1, 8, 3, 1, [
          {"name" => "白目", "mp" => 5, "atack" => 0, "speed" => 8},
          {"name" => "ボス(雑魚)の意地", "mp" => 10, "atack" => 5, "speed" => 0}
        ],
        10, 21
        )
      end

      @@der = 2
    end
    if Input.key_push?(K_D)
      case(@@map[@@y][@@x + 1])
      when 0
        @@x += 1
      when 2
        @@s_f = 1
        @@go = 0
        @@faifai_data = Rpg_enemy.new(10, 10,  8, 8, 5, 0, 4, 4, 1, [
          {"name" => "炙る", "mp" => 4, "atack" => 0, "speed" => 1},
          {"name" => "180度に熱する", "mp" => 6, "atack" => 3, "speed" => 2},
        ],
        4, 7)
      when 3
        @@s_f = 1
        @@go = 1
        @@w_keshin_data = Shooting_enemy.new(20, 20, 10, 10, 4, 3, 1, 0, 3, 300, 2, 0, 4, 7)
      when 4
        @@go = 2
        @@hatarou_data = Fighting_enemy.new(15, 15, 1, 3, 4, 0, 0, 400, 3, 4, 7)
        @@s_f = 1
      when 5
        @@s_f = 1
        @@go = 3
        @@bossun_data = Rpg_enemy.new(15, 15, 10, 10, 7, 1, 8, 3, 1,[
          {"name" => "白目", "mp" => 5, "atack" => 0, "speed" => 8},
          {"name" => "ボス(雑魚)の意地", "mp" => 10, "atack" => 5, "speed" => 0}
        ],
        8, 21
        )
      end
      @@der = 1
    end
    if Input.key_push?(K_T)
      @@s_f = 6
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
      @@s_f = 7 if cnt != 0
    end
  end

  def self.wait
    if Op_update.AnyKey_push? || Input.key_push?(K_RETURN)
      case(@@s_f)
      when 9, 10
        if @@s_f == 9
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
            @@s_f = 6
            @@sos = 0
          else
            @@s_f = 7
          end
        else
          @@s_f = 7
        end
      end
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
      @@s_f = 6
      @@sos = 0
    end
    if Input.key_push?(K_RETURN)
      @@s_f = 8
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
        @@s_f = 9
      else
        @@s_f = 10
      end
    end
  end


  def self.check_mission
    if @@mission_num == 1 && @@e_f == 3
      @@mission_num = 2
      @@map[9][3] = 5
    end
    if @@mission_num == 2 && @@e_f == 4
      @@chenge = 12
      $player.result_add(0)
    end
  end


  def self.move
    F_q.check_mission
    case(@@s_f)
    when 0
      F_q.ple_move
    when 6
      F_q.menu_sel
    when 7
      F_q.item_sel
    when 8
      F_q.con_sel
    when 9, 10
      F_q.wait
    end
  end

  def self.draw
    #スクロール
    case(@@s_f)
    when 0, -1, 1, 6, 7, 8, 9, 10, 11
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
            Window.draw(x_i * 75, y_i * 75, @@soil)
          when 1
            Window.draw(x_i * 75, y_i * 75, @@tree)
          when 2
            Window.draw(x_i * 75, y_i * 75, @@soil)
            Window.draw(x_i * 75, y_i * 75, @@faifai)
          when 3
            Window.draw(x_i * 75, y_i * 75, @@soil)
            Window.draw(x_i * 75, y_i * 75, @@w_keshin[2])
          when 4
            Window.draw(x_i * 75, y_i * 75, @@soil)
            Window.draw(x_i * 75, y_i * 75, @@leaf_taro)
          when 5
            Window.draw(x_i * 75, y_i * 75, @@soil)
            Window.draw(x_i * 75, y_i * 75, @@bossun)
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
      @@h_b1 = Sprite.new(330, 5, Image.new(264, 24, C_WHITE))
      @@b_b1 = Sprite.new(332, 7, Image.new(260, 20, C_BLACK))
      Sprite.draw([@@h_b1, @@b_b1])
      case(@@mission_num)
      when 1
        Window.draw_font(332, 7, "ミッション: 1/2 敵を倒せ #{@@e_f}/3", $font_20)
      when 2
        Window.draw_font(332, 7, "ミッション: FINAL ボスを倒せ!!!", $font_20)
      end

      if @@s_f >= 6 && @@s_f <= 11
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
          Window.draw_font(192, @@sos * 20 + 41, "◎", $font_20) if @@s_f >= 7
          
          if @@s_f >= 7
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


          if @@s_f >= 8
            #ボード
            @@h_b = Sprite.new(185, 105, Image.new(254, 64, C_WHITE))
            @@b_b = Sprite.new(187, 107, Image.new(250, 60, C_BLACK))
            Sprite.draw([@@h_b, @@b_b])
            
            #メッセージ
            Window.draw_font(187, 107, "使いますか?", $font_30)
            Window.draw_font(187, 137, "   はい    いいえ", $font_30)
            Window.draw_font(187 + @@con * 90, 137, "◎", $font_30)
            if @@s_f == 10
              @@h_b = Sprite.new(185, 125, Image.new(260, 40, C_WHITE))
              @@b_b = Sprite.new(187, 127, Image.new(256, 36, C_BLACK))
              Sprite.draw([@@h_b, @@b_b])

              Window.draw_font(187, 127, "使用不可!", $font_30)
            elsif @@s_f == 9
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
      #RPG ファイファイ
      num, @@faifai_data = Rpg.draw(@@faifai, "ファイファイ", @@faifai_data)
      if num == 3
        @@chenge = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@map[2][3] = 0
          @@e_f += 1
        end
      end
    when 3
      #シューティング 水の化身
      num, @@w_keshin_data = Shooting.draw("水の化身", @@w_keshin, @@w_keshin_data)
      if num == 3
        @@chenge = 11
      end
      if num  == 1 || num == 2
        @@s_f = 0
        @@map[3][10] = 0
        if num == 2
          @@e_f += 1
        end
      end
    when 4
      #格闘 葉太郎
      num, @@hatarou_data = Fighting.draw("葉太郎", @@hatarou, @@hatarou_data)

      if num == 3
        @@chenge = 11
      end
      if num == 2 || num == 1
        @@s_f = 0
        @@map[9][9] = 0
        if num == 2
          @@e_f += 1
        end
      end
    when 5
      #RPG ボッスン
      num, @@bossun_data = Rpg.draw(@@bossun, "ボッスン", @@bossun_data)
      if num == 3
        @@chenge = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          $player.result_add(0)
          @@chenge = 12
        end
      end
    
    end

    if @@chenge != 1
      num = @@chenge
      @@map = [
        [1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,2,0,0,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1,0,0,3,0,1],
        [1,1,0,1,0,1,0,1,0,0,0,0,1],
        [1,0,0,0,0,0,0,1,1,1,1,1,1],
        [1,0,1,0,1,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,1,0,0,0,0,0,1],
        [1,0,0,0,0,0,1,0,0,0,0,0,1],
        [1,0,0,0,0,0,1,0,0,4,0,0,1],
        [1,0,0,0,0,0,1,0,0,0,0,0,1],
        [1,0,0,0,0,0,1,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1]
      ]
    
      @@x = 1
      @@y = 11
      @@s_f = -1
      @@der = 2
      @@e_f = 0
      @@time = 0
      @@mission_max = 2
      @@mission_num = 1
      @@go = -1
      @@chenge = 1
      return num
    end

    return 1
  end
end