require_relative '../../battle/rpg'
require_relative '../../battle/shooting'
require_relative '../../battle/fighting'
require_relative '../../chara_state/rpg_enemy'
require_relative '../../chara_state/shooting_enemy'
require_relative '../../chara_state/fighting_enemy'

class Bakemono
  @@map = [
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,3,0,0,0,4,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,5,0,0,0,6,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,7,0,0,0,8,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
  ]

  @@change = 13
  @@s_f = -1
  @@x = 1
  @@y = 17
  @@der = 2
  @@time = 0
  @@e_f = 0
  @@mission_num = 1
  @@go = 0
  @@sel = 0
  @@sos = 0
  @@con = 0

  #写真
  @@bake_floor = Image.load('image/bake_floor.png')
  @@hei = Image.load('image/hei.png')
  @@desk = Image.load('image/desk.png').set_color_key(C_WHITE)
  @@algo_kosen = Image.load('image/algo_kosen.png').set_color_key(C_WHITE)
  @@gari_kosen = Image.load('image/gari_kosen2.png').set_color_key(C_WHITE)
  @@kadai_kosen = Image.load('image/kadai_kosen.png').set_color_key(C_WHITE)
  @@ryunen_kosen = Image.load('image/ryunen_kosen.png').set_color_key(C_WHITE)
  @@oto_kosen = Image.load('image/oto_kosen2.png').set_color_key(C_WHITE)
  @@tani_kosen = Image.load('image/tani_kosen.png').set_color_key(C_WHITE)
  @@shooting_gari_kosen = [
    Image.load('image/gari_kosen0.png').set_color_key(C_WHITE),
    Image.load('image/gari_kosen1.png').set_color_key(C_WHITE),
    Image.load('image/gari_kosen2.png').set_color_key(C_WHITE),
    Image.load('image/gari_kosen3.png').set_color_key(C_WHITE)
  ]
  @@kakutou_kadai_kosen = [
    Image.load('image/kadai_kosen0-0.png').set_color_key(C_WHITE),
    Image.load('image/kadai_kosen0-1.png').set_color_key(C_WHITE),
    Image.load('image/kadai_kosen1-0.png').set_color_key(C_WHITE),
    Image.load('image/kadai_kosen1-1.png').set_color_key(C_WHITE)
  ]
  @@kakutou_ryunen_kosen = [
    Image.load('image/ryunen_kosen0-0.png').set_color_key(C_WHITE),
    Image.load('image/ryunen_kosen0-1.png').set_color_key(C_WHITE),
    Image.load('image/ryunen_kosen1-0.png').set_color_key(C_WHITE),
    Image.load('image/ryunen_kosen1-1.png').set_color_key(C_WHITE)
  ]
  @@shooting_oto_kosen = [
    Image.load('image/oto_kosen0.png').set_color_key(C_WHITE),
    Image.load('image/oto_kosen1.png').set_color_key(C_WHITE),
    Image.load('image/oto_kosen2.png').set_color_key(C_WHITE),
    Image.load('image/oto_kosen3.png').set_color_key(C_WHITE)
  ]
  @@rejend_kadai = Image.load('image/rejend_kadai.png').set_color_key(C_WHITE)
  @@shooting_rejend_kadai = [
    Image.load('image/rejend_kadai0.png').set_color_key(C_WHITE),
    Image.load('image/rejend_kadai1.png').set_color_key(C_WHITE),
    Image.load('image/rejend_kadai2.png').set_color_key(C_WHITE),
    Image.load('image/rejend_kadai3.png').set_color_key(C_WHITE)
  ]
  @@kakutou_rejend_kadai = [
    Image.load('image/rejend_kadai0-0.png').set_color_key(C_WHITE),
    Image.load('image/rejend_kadai0-1.png').set_color_key(C_WHITE),
    Image.load('image/rejend_kadai1-0.png').set_color_key(C_WHITE),
    Image.load('image/rejend_kadai1-1.png').set_color_key(C_WHITE)
  ]

  def self.ple_move
    if Input.key_push?(K_W)
      case(@@map[@@y - 1][@@x])
      when 0
        @@y -= 1
      when 3
        @@algo_data = Rpg_enemy.new(110, 110, 60, 60, 30, 90, 150, 13, 1, [
          {"name" => "動的計画法", "mp" => 10, "atack" => 40, "speed" => 20},
          {"name" => "ダイクストラ法", "mp" => 6, "atack" => 60, "speed" => 15}
        ], 150, 130)
        @@s_f = 1
        @@go = 0
      when 4
        @@gari_data = Shooting_enemy.new(130, 130, 80, 80, 30, 160, 3, 160, 15, 130, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 1
      when 5
        @@kadai_data = Fighting_enemy.new(140, 140, 2, 25, 2, 150, 0, 120, 3, 150, 200)
        @@s_f = 1
        @@go = 2
      when 6
        @@ryunen_data = Fighting_enemy.new(160, 160, 2, 150, 8, 190, 0, 58, 3, 160, 200)
        @@s_f = 1
        @@go = 3
      when 7
        @@oto_data = Shooting_enemy.new(140, 140, 60, 60, 20, 120, 4, 130, 10, 100, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 4
      when 8
        @@tani_data = Rpg_enemy.new(150, 150, 80, 80, 30, 150, 140, 10, 2, [
          {"name" => "単位取れればすべてよし", "mp" => 30, "atack" => 70, "speed" => 10},
          {"name" => "高精度成績計算法", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 160, 200)
        @@s_f = 1
        @@go = 5
      when 9
        @@rejend_data = Rpg_enemy.new(200, 200, 150, 150, 150, 300, 260, 99, 1, [
          {"name" => "絶望のレポート", "mp" => 30, "atack" => 80, "speed" => 10},
          {"name" => "超特大数学課題", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 1600, 180)
        @@s_f = 1
        @@go = 6
      end
      @@der = 0
    end
    if Input.key_push?(K_A)
      case(@@map[@@y][@@x - 1])
      when 0
        @@x -= 1
      when 3
        @@algo_data = Rpg_enemy.new(110, 110, 60, 60, 30, 90, 150, 13, 1, [
          {"name" => "動的計画法", "mp" => 10, "atack" => 40, "speed" => 20},
          {"name" => "ダイクストラ法", "mp" => 6, "atack" => 60, "speed" => 15}
        ], 150, 130)
        @@s_f = 1
        @@go = 0
      when 4
        @@gari_data = Shooting_enemy.new(130, 130, 80, 80, 30, 160, 3, 160, 15, 130, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 1
      when 5
        @@kadai_data = Fighting_enemy.new(140, 140, 2, 25, 2, 150, 0, 120, 3, 150, 200)
        @@s_f = 1
        @@go = 2
      when 6
        @@ryunen_data = Fighting_enemy.new(160, 160, 2, 150, 8, 190, 0, 58, 3, 160, 200)
        @@s_f = 1
        @@go = 3
      when 7
        @@oto_data = Shooting_enemy.new(140, 140, 60, 60, 20, 120, 4, 130, 10, 100, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 4
      when 8
        @@tani_data = Rpg_enemy.new(150, 150, 80, 80, 30, 150, 140, 10, 2, [
          {"name" => "単位取れればすべてよし", "mp" => 30, "atack" => 70, "speed" => 10},
          {"name" => "高精度成績計算法", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 160, 200)
        @@s_f = 1
        @@go = 5
      when 9
        @@rejend_data = Rpg_enemy.new(200, 200, 150, 150, 150, 300, 260, 99, 1, [
          {"name" => "絶望のレポート", "mp" => 30, "atack" => 80, "speed" => 10},
          {"name" => "超特大数学課題", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 1600, 180)
        @@s_f = 1
        @@go = 6
      end
      @@der = 3
    end
    if Input.key_push?(K_S)
      case(@@map[@@y + 1][@@x])
      when 0
        @@y += 1
      when 3
        @@algo_data = Rpg_enemy.new(110, 110, 60, 60, 30, 90, 150, 13, 1, [
          {"name" => "動的計画法", "mp" => 10, "atack" => 40, "speed" => 20},
          {"name" => "ダイクストラ法", "mp" => 6, "atack" => 60, "speed" => 15}
        ], 150, 130)
        @@s_f = 1
        @@go = 0
      when 4
        @@gari_data = Shooting_enemy.new(130, 130, 80, 80, 30, 160, 3, 160, 15, 130, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 1
      when 5
        @@kadai_data = Fighting_enemy.new(140, 140, 2, 25, 2, 150, 0, 120, 3, 150, 200)
        @@s_f = 1
        @@go = 2
      when 6
        @@ryunen_data = Fighting_enemy.new(160, 160, 2, 150, 8, 190, 0, 58, 3, 160, 200)
        @@s_f = 1
        @@go = 3
      when 7
        @@oto_data = Shooting_enemy.new(140, 140, 60, 60, 20, 120, 4, 130, 10, 100, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 4
      when 8
        @@tani_data = Rpg_enemy.new(150, 150, 80, 80, 30, 150, 140, 10, 2, [
          {"name" => "単位取れればすべてよし", "mp" => 30, "atack" => 70, "speed" => 10},
          {"name" => "高精度成績計算法", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 160, 200)
        @@s_f = 1
        @@go = 5
      when 9
        @@rejend_data = Rpg_enemy.new(200, 200, 150, 150, 150, 300, 260, 99, 1, [
          {"name" => "絶望のレポート", "mp" => 30, "atack" => 80, "speed" => 10},
          {"name" => "超特大数学課題", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 1600, 180)
        @@s_f = 1
        @@go = 6
      end
      @@der = 2
    end
    if Input.key_push?(K_D)
      case(@@map[@@y][@@x + 1])
      when 0
        @@x += 1
      when 3
        @@algo_data = Rpg_enemy.new(110, 110, 60, 60, 30, 90, 150, 13, 1, [
          {"name" => "動的計画法", "mp" => 10, "atack" => 40, "speed" => 20},
          {"name" => "ダイクストラ法", "mp" => 6, "atack" => 60, "speed" => 15}
        ], 150, 130)
        @@s_f = 1
        @@go = 0
      when 4
        @@gari_data = Shooting_enemy.new(130, 130, 80, 80, 30, 160, 3, 160, 15, 130, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 1
      when 5
        @@kadai_data = Fighting_enemy.new(140, 140, 2, 25, 2, 150, 0, 120, 3, 150, 200)
        @@s_f = 1
        @@go = 2
      when 6
        @@ryunen_data = Fighting_enemy.new(160, 160, 2, 150, 8, 190, 0, 58, 3, 160, 200)
        @@s_f = 1
        @@go = 3
      when 7
        @@oto_data = Shooting_enemy.new(140, 140, 60, 60, 20, 120, 4, 130, 10, 100, 2, 0, 100, 150)
        @@s_f = 1
        @@go = 4
      when 8
        @@tani_data = Rpg_enemy.new(150, 150, 80, 80, 30, 150, 140, 10, 2, [
          {"name" => "単位取れればすべてよし", "mp" => 30, "atack" => 70, "speed" => 10},
          {"name" => "高精度成績計算法", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 160, 200)
        @@s_f = 1
        @@go = 5
      when 9
        @@rejend_data = Rpg_enemy.new(200, 200, 150, 150, 150, 300, 260, 99, 1, [
          {"name" => "絶望のレポート", "mp" => 30, "atack" => 80, "speed" => 10},
          {"name" => "超特大数学課題", "mp" => 50, "atack" => 90, "speed" => 20}
        ], 1600, 180)
        @@s_f = 1
        @@go = 6
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
      when 16
        @@s_f = 1
        @@go = 7
      when 17
        @@s_f = 1
        @@go = 8
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
      Bakemono.ple_move
    when 7
      Bakemono.menu_sel
    when 8
      Bakemono.item_sel
    when 9
      Bakemono.con_sel
    when 10, 11, 16, 17
      Bakemono.wait
    end
  end


  def self.check_mission
    case(@@mission_num)
    when 1
      if @@e_f == 6
        @@mission_num = 2
        @@map[8][8] = 9
      end
    end
  end

  def self.draw
    Bakemono.check_mission

    case(@@s_f)
    when 0, 1, -1, 7 .. 12, 16, 17
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
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
          when 1
            Window.draw(x_i * 75, y_i * 75, @@hei)
          when 2
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@desk)
          when 3
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@algo_kosen)
          when 4
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@gari_kosen)
          when 5
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@kadai_kosen)
          when 6
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@ryunen_kosen)
          when 7
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@oto_kosen)
          when 8
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@tani_kosen)
          when 9
            Window.draw(x_i * 75, y_i * 75, @@bake_floor)
            Window.draw(x_i * 75, y_i * 75, @@rejend_kadai)
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
        Window.draw_font(332, 7, "ミッション: 1/2 敵を倒せ #{@@e_f}/6", $font_20)
      when 2
        Window.draw_font(332, 7, "ミッション: FINAL ボスを倒せ!!!", $font_20)
      end

      if @@s_f == 16 || @@s_f == 17
        #ボード表示
        @@h_b1 = Sprite.new(5, 350, Image.new(590, 245, C_WHITE))
        @@b_b1 = Sprite.new(7, 352, Image.new(586, 241, C_BLACK))
        Sprite.draw([@@h_b1, @@b_b1])

        case(@@s_f)
        when 16
          Window.draw_font(7, 352, "それで勝ったつもりか?", $font_20)
        when 17
          Window.draw_font(7, 352, "最終形態・起動", $font_20)
        end
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
          when 5
            @@s_f = 18
          when 6
            @@s_f = 13
          when 7
            @@s_f = 14
          when 8
            @@s_f = 15
          end
          @@time = 0
        end
      end
    when 2
      #RPG アルゴリズム高専生
      num, @@algo_data = Rpg.draw(@@algo_kosen, "アルゴリズム高専生", @@algo_data)

      if num == 3
        @@change = 11
      end
      if num == 2 || num == 1
        @@s_f = 0
        if num == 2
          @@map[5][6] = 0
          @@e_f += 1
        end
      end
    when 3
      #シューティング　ガリ勉高専生
      num, @@gari_data = Shooting.draw("ガリ勉高専生", @@shooting_gari_kosen, @@gari_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@map[5][10] = 0
          @@e_f += 1
        end
      end
    when 4
       #格闘　課題捨て高専生
       num, @@rkadai_data = Fighting.draw("課題捨て高専生", @@kakutou_kadai_kosen, @@kadai_data)

       if num == 3
         @@change = 11
       end
       if num == 1 || num == 2
         @@s_f = 0
         if num == 2
           @@map[9][6] = 0
           @@e_f += 1
         end
       end
    when 5
      #格闘　万年留年高専生
      num, @@ryunen_data = Fighting.draw("万年留年高専生", @@kakutou_ryunen_kosen, @@ryunen_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@map[9][10] = 0
          @@e_f += 1
        end
      end
    when 6
      #シューティング 音ゲーマー高専生
      num, @@oto_data = Shooting.draw("音ゲーマー高専生", @@shooting_oto_kosen, @@oto_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@map[13][6] = 0
          @@e_f += 1
        end
      end
    when 18
      #RPG 単位大好き高専生
      num, @@tani_data = Rpg.draw(@@tani_kosen, "単位好き高専生",  @@tani_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@map[13][10] = 0
          @@e_f += 1
        end
      end
    when 13
      #BOSS RPG 伝説の課題
      num, @@rejend_data = Rpg.draw(@@rejend_kadai, "伝説の課題",  @@rejend_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@rejend_data = Shooting_enemy.new(230, 230, 90, 90, 20, 200, 3, 220, 10, 80, 2, 0, 220, 250)
          @@s_f = 16
        end
      end
    when 14
      #BOSS シューティング 伝説の課題
      num, @@rejend_data = Shooting.draw("伝説の課題",  @@shooting_rejend_kadai, @@rejend_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@rejend_data = Fighting_enemy.new(300, 300, 2, 240, 8, 250, 0, 150, 3, 440, 600)
          @@s_f = 17
        end
      end
    when 15
      #BOSS 格闘 伝説の課題
      num, @@rejend_data = Fighting.draw("伝説の課題",  @@kakutou_rejend_kadai, @@rejend_data)

      if num == 3
        @@change = 11
      end
      if num == 1 || num == 2
        @@s_f = 0
        if num == 2
          @@change = 14
        end
      end
    end

    if @@change != 13
      @@map = [
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,3,0,0,0,4,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,5,0,0,0,6,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,7,0,0,0,8,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,2,0,0,0,2,0,0,0,2,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
        [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
      ]
    
      num = @@change
      @@change = 13
      @@s_f = -1
      @@x = 1
      @@y = 17
      @@der = 2
      @@time = 0
      @@e_f = 0
      @@mission_num = 1
      @@go = 0
      @@sel = 0
      @@sos = 0
      @@con = 0
      return num
    end

    return @@change
  end
end