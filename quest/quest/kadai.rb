require_relative '../../battle/rpg'
require_relative '../../battle/shooting'
require_relative '../../battle/fighting'
require_relative '../../chara_state/rpg_enemy'
require_relative '../../chara_state/shooting_enemy'
require_relative '../../chara_state/fighting_enemy'

class Kadai
  @@map = [
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
    [1,0,0,0,0,0,0,0,2,0,1,1,1,1,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
    [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
  ]

  @@change = 9
  @@s_f = -1
  @@x = 1
  @@y = 17
  @@der = 2
  @@time = 0
  @@cnt_t = 0
  @@mission_num = 1
  @@go = 0
  @@before_meet = 0
  @@sel = 0
  @@sos = 0
  @@con = 0
  
  #写真
  @@kadai_floor = Image.load('image/kadai_floor.png')
  @@kabe = Image.load('image/kabe.png')
  @@tani = Image.load('image/tani.png').set_color_key(C_WHITE)
  @@kadai = Image.load('image/kadai.png').set_color_key(C_WHITE)
  @@report = Image.load('image/report.png').set_color_key(C_WHITE)
  @@kadai_king = Image.load('image/kadai_king.png').set_color_key(C_WHITE)
  @@shooting_kadai = [
    Image.load('image/kadai0.png').set_color_key(C_WHITE),
    Image.load('image/kadai1.png').set_color_key(C_WHITE),
    Image.load('image/kadai2.png').set_color_key(C_WHITE),
    Image.load('image/kadai3.png').set_color_key(C_WHITE)
  ]
  @@fighting_report = [
    Image.load('image/report0-0.png').set_color_key(C_WHITE),
    Image.load('image/report0-1.png').set_color_key(C_WHITE),
    Image.load('image/report1-0.png').set_color_key(C_WHITE),
    Image.load('image/report1-1.png').set_color_key(C_WHITE)
  ]

  @@tani_place = [
    [1,1],[1,15],[17,15],[17,1],[9,4],[11,11],[5,8],[11,7],[6,14]
  ]


  def self.ple_move
    if Input.key_push?(K_W)
      case(@@map[@@y - 1][@@x])
      when 0
        @@y -= 1
        if @@mission_num == 2
          @@before_meet += 1
          Kadai.ran_meet  
        end
      when 2
        @@kadai_shooting_data = Shooting_enemy.new(50, 50, 30, 30, 10, 45, 10, 40, 20, 100, 3, 0, 45, 50)
        @@s_f = 1
        @@go = 0
      when 3
        @@map[@@y - 1][@@x] = 0
        @@y -= 1
        @@cnt_t += 1
      when 4
        @@kadai_king_data = Rpg_enemy.new(70, 70, 30, 30, 30, 30, 40, 200, 1, [
          {"name" => "締め切りまであと3秒", "mp" => 15, "atack" => 40, "speed" => 10},
          {"name" => "未提出なら単位認定不可", "mp" => 20, "atack" => 50, "speed" => 15}
        ], 70, 150)
        @@s_f = 1
        @@go = 1
      end
      @@der = 0
    end
    if Input.key_push?(K_A)
      case(@@map[@@y][@@x - 1])
      when 0
        @@x -= 1
        if @@mission_num == 2
          @@before_meet += 1
          Kadai.ran_meet  
        end
      when 2
        @@kadai_shooting_data = Shooting_enemy.new(50, 50, 30, 30, 10, 45, 10, 40, 20, 100, 3, 0, 45, 50)
        @@s_f = 1
        @@go = 0
      when 3
        @@map[@@y][@@x - 1] = 0
        @@x -= 1
        @@cnt_t += 1
      when 4
        @@kadai_king_data = Rpg_enemy.new(70, 70, 30, 30, 30, 30, 40, 200, 1, [
          {"name" => "締め切りまであと3秒", "mp" => 15, "atack" => 40, "speed" => 10},
          {"name" => "未提出なら単位認定不可", "mp" => 20, "atack" => 50, "speed" => 15}
        ], 70, 150)
        @@s_f = 1
        @@go = 1
      end
      @@der = 3
    end
    if Input.key_push?(K_S)
      case(@@map[@@y + 1][@@x])
      when 0
        @@y += 1
        if @@mission_num == 2
          @@before_meet += 1
          Kadai.ran_meet  
        end
      when 2
        @@kadai_shooting_data = Shooting_enemy.new(50, 50, 30, 30, 10, 45, 10, 40, 20, 100, 3, 0, 45, 50)
        @@s_f = 1
        @@go = 0
      when 3
        @@map[@@y + 1][@@x] = 0
        @@y += 1
        @@cnt_t += 1
      when 4
        @@kadai_king_data = Rpg_enemy.new(70, 70, 30, 30, 30, 30, 40, 200, 1, [
          {"name" => "締め切りまであと3秒", "mp" => 15, "atack" => 40, "speed" => 10},
          {"name" => "未提出なら単位認定不可", "mp" => 20, "atack" => 50, "speed" => 15}
        ], 70, 150)
        @@s_f = 1
        @@go = 1
      end
      @@der = 2
    end
    if Input.key_push?(K_D)
      case(@@map[@@y][@@x + 1])
      when 0
        @@x += 1
        if @@mission_num == 2
          @@before_meet += 1
          Kadai.ran_meet  
        end
      when 2
        @@kadai_shooting_data = Shooting_enemy.new(50, 50, 30, 30, 10, 45, 10, 40, 20, 100, 3, 0, 45, 50)
        @@s_f = 1
        @@go = 0
      when 3
        @@map[@@y][@@x + 1] = 0
        @@x += 1
        @@cnt_t += 1
      when 4
        @@kadai_king_data = Rpg_enemy.new(70, 70, 30, 30, 30, 30, 40, 200, 1, [
          {"name" => "締め切りまであと3秒", "mp" => 15, "atack" => 40, "speed" => 10},
          {"name" => "未提出なら単位認定不可", "mp" => 20, "atack" => 50, "speed" => 15}
        ], 70, 150)
        @@s_f = 1
        @@go = 1
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
        @@go = 2
        @@kadai_rpg_data = Rpg_enemy.new(50, 50, 30, 30, 20, 15, 25, 16, 1, [
          {"name" => "締め切りまであと10分", "mp" => 15, "atack" => 30, "speed" => 7},
          {"name" => "y=sin1/2π+tan2/3πのグラフをかけ", "mp" => 20, "atack" => 40, "speed" => 8}
        ], 40, 40)
      elsif r <= 20
        @@s_f = 1
        @@go = 3
        @@report_rpg_kadai = Rpg_enemy.new(60, 60, 40, 40, 30, 20, 30, 15, 2, [
          {"name" => "フレキシブル基盤の特徴を30ページにまとめよ", "mp" => 15, "atack" => 35, "speed" => 7},
          {"name" => "数学大課題", "mp" => 20, "atack" => 45, "speed" => 8}
        ], 50, 50)
      elsif r <= 30
        @@s_f = 1
        @@go = 4
        @@report_fighting_data = Fighting_enemy.new(50, 50, 3, 20, 15, 25, 0, 200, 1, 25, 30)
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
      Kadai.ple_move
    when 7
      Kadai.menu_sel
    when 8
      Kadai.item_sel
    when 9
      Kadai.con_sel
    when 10, 11
      Kadai.wait
    end
  end


  def self.check_mission
    case(@@mission_num)
    when 2
      if @@cnt_t == 9
        @@mission_num = 3
        @@map[8][7] = 4
      end
    end
  end

  def self.draw
    Kadai.check_mission

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
            Window.draw(x_i * 75, y_i * 75, @@kadai_floor)
          when 1
            Window.draw(x_i * 75, y_i * 75, @@kabe)
          when 2
            Window.draw(x_i * 75, y_i * 75, @@kadai_floor)
            Window.draw(x_i * 75, y_i * 75, @@kadai)
          when 3
            Window.draw(x_i * 75, y_i * 75, @@kadai_floor)
            Window.draw(x_i * 75, y_i * 75, @@tani)
          when 4
            Window.draw(x_i * 75, y_i * 75, @@kadai_floor)
            Window.draw(x_i * 75, y_i * 75, @@kadai_king)
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
        Window.draw_font(282, 7, "ミッション: 1/3 見えてる敵を倒せ 0/1", $font_20)
      when 2
        Window.draw_font(282, 7, "ミッション: 2/3 単位を集めろ #{@@cnt_t}/9", $font_20)
      when 3
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
      #シューティング 課題
      num, @@kadai_shooting_data = Shooting.draw("課題", @@shooting_kadai, @@kadai_shooting_data)

      if num == 3
        @@change = 11
      end
      if num == 2 || num == 1
        @@s_f = 0
        @@map[8][8] = 0
        if num == 2
          @@mission_num += 1
          @@tani_place.size.times do |i|
            @@map[@@tani_place[i][0]][@@tani_place[i][1]] = 3
          end
        end
      end
    when 3
      #BOSS RPG 課題の王
      num, @@kadai_king_data = Rpg.draw(@@kadai_king, "課題の王", @@kadai_king_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          $player.result_add(8)
          @@change = 12
        end
      end
    when 4
      #RPG　課題
      num, @@kadai_rpg_data = Rpg.draw(@@kadai, "課題", @@kadai_rpg_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
      end
    when 5
      #RPG レポート
      num, @@report_rpg_kadai = Rpg.draw(@@report, "レポート", @@report_rpg_kadai)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
      end
    when 6
      #格闘 レポート
      num, @@report_fighting_data = Fighting.draw("レポート", @@fighting_report, @@report_fighting_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
      end
    end

    if @@change != 9
      @@map = [
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
        [1,0,0,0,0,0,0,0,2,0,1,1,1,1,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
        [1,0,0,1,1,1,1,0,0,0,1,1,1,1,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
      ]
    
      num = @@change
      @@change = 9
      @@s_f = -1
      @@x = 1
      @@y = 17
      @@der = 2
      @@time = 0
      @@cnt_t = 0
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