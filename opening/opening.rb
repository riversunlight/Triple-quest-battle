require 'dxruby'
require_relative 'op_update'
require_relative '../data/data'
require_relative 'name_cho'

class Opening
  #状態管理
  @@sel = 0 #キー入力での操作のときの、選んでるキー
  @@flag = 0 #0 =>ホーム 1 => ルール 2 => 設定 3 =>　データをロード
  @@m_k_f = 0 #0 => マウス入力 1 => キー入力
  @@set_m = 0 #0 =>設定の画面 1=> スキンの変更 2 => コメントスキップのオンオフ

  def initialize
    #ホーム画面描画用
    @@start_button = Sprite.new(200, 150, Image.new(200, 80,C_BLUE))
    @@continue_button = Sprite.new(200, 250, Image.new(200, 80,C_BLUE))
    @@ru_ru_button = Sprite.new(200, 350, Image.new(200, 80,C_GREEN))
    @@setting_button = Sprite.new(200, 450, Image.new(200, 80,C_GREEN))
    @@back_ground = Image.load('image/opening_haikei.png')

    #ルール画面描画用
    @@back_g_r = Sprite.new(0, 0, Image.new(600, 600, C_GREEN))
    @@back_button = Sprite.new(50, 550, Image.new(100, 40, C_BLUE))

    #設定描画用(全体)
    @@back_g_s = Sprite.new(0, 0, Image.new(600, 600, C_GREEN))
    @@skin_button = Sprite.new(400, 200, Image.new(150, 50, C_BLUE))
    @@skip_button = Sprite.new(400, 300, Image.new(150, 50, C_BLUE))

    #設定(スキン)
    @@skin_yuusya = Sprite.new(225, 200, Image.new(150, 50, C_BLUE))
    @@skin_tako = Sprite.new(225, 300, Image.new(150, 50, C_BLUE))
    @@skin_ika = Sprite.new(225, 400, Image.new(150, 50, C_BLUE))

    #設定(コメントスキップ)
    @@skip_on = Sprite.new(225, 250, Image.new(150, 50, C_BLUE))
    @@skip_off = Sprite.new(225, 350, Image.new(150, 50, C_BLUE))

    #データロード用
    @@back_g_l = Sprite.new(0, 0, Image.new(600, 600, C_YELLOW))
    @@data1_show = Sprite.new(50, 50, Image.new(200, 200, C_WHITE))
    @@data2_show = Sprite.new(350, 50, Image.new(200, 200, C_WHITE))
    @@data3_show = Sprite.new(50, 350, Image.new(200, 200, C_WHITE))
    @@data4_show = Sprite.new(350, 350, Image.new(200, 200, C_WHITE))
    @@no_data = Image.load('image/No_Data.png')
    @@msg = [
      "NO DATA",
      "NO DATA",
      "NO DATA",
      "NO DATA"
    ]
    @@lv = ["", "", "", ""]

    #名前の入力用
    @@back_g_n = Sprite.new(0, 0, Image.new(600, 600, C_BLACK))
  end

  def update(x, y)
    m = Sprite.new(x, y, Image.new(1, 1, C_RED))
    if @@m_k_f == 0
      if Input.key_push?(K_W) || Input.key_push?(K_S)
        @@m_k_f = 1
      end
      if m === @@start_button
        @@start_button = Sprite.new(200, 150, Image.new(200, 80,C_RED))
        if Input.mouse_push?(M_LBUTTON)
          @@flag = 4
        end
      end
  
      if m === @@continue_button
        @@continue_button = Sprite.new(200, 250, Image.new(200, 80,C_RED))
        if Input.mouse_push?(M_LBUTTON)
          @@flag = 3
        end
      end
  
      if m === @@ru_ru_button
        @@ru_ru_button = Sprite.new(200, 350, Image.new(200, 80,C_MAGENTA))
        if Input.mouse_push?(M_LBUTTON)
          @@flag = 1
        end
      end
  
      if m === @@setting_button
        @@setting_button = Sprite.new(200, 450, Image.new(200, 80,C_MAGENTA))
        if Input.mouse_push?(M_LBUTTON)
          @@flag = 2
        end
      end
    else
      if m === @@start_button || m === @@continue_button || m === @@ru_ru_button ||  m === @@setting_button
        @@sel = 0
        @@m_k_f = 0
      else
        if Input.key_push?(K_W)
          @@sel -= 1
        end
        if Input.key_push?(K_S)
          @@sel += 1
        end

        if Input.key_push?(K_RETURN)
          case (@@sel)
          when 0
            @@flag = 4
          when 1
            @@flag = 3
          when 2
            @@flag = 1
          when 3
            @@flag = 2
          end
        end

        @@sel = (@@sel + 4) % 4;
        case (@@sel)
        when 0
          @@start_button = Sprite.new(200, 150, Image.new(200, 80,C_RED))
        when 1
          @@continue_button = Sprite.new(200, 250, Image.new(200, 80,C_RED))
        when 2
          @@ru_ru_button = Sprite.new(200, 350, Image.new(200, 80,C_MAGENTA))
        when 3
          @@setting_button = Sprite.new(200, 450, Image.new(200, 80,C_MAGENTA))
        end
      end
    end
  end

  def draw
    x = Input.mouse_pos_x
    y = Input.mouse_pos_y

    case(@@flag)
    when 0
      update(x, y)
      Window.draw(0, 0, @@back_ground)
      Sprite.draw([@@start_button, @@continue_button, @@ru_ru_button, @@setting_button])
      Window.draw_font(210, 160, "初めから", Font.new(50))
      Window.draw_font(210, 260, "続きから", Font.new(50))
      Window.draw_font(210, 360, "  説明  ", Font.new(50))
      Window.draw_font(210, 460, "  設定  ", Font.new(50))
      Window.draw_font(0, 0, "トリプルクエストバトル", Font.new(60), {color: C_CYAN})
    when 1
      @@flag, @@back_button = Op_update.update_ru_re(x, y)
      Sprite.draw([@@back_g_r, @@back_button])

      #概要説明
      Window.draw_font(0, 0, "=====ルール=====", Font.new(32))
      Window.draw_font(0, 33, "・様々なクエストを攻略する冒険型ゲーム!", Font.new(20))
      Window.draw_font(0, 66, "・RPG、シューティング、格闘の3つのモードで敵と対戦!", Font.new(20))
      Window.draw_font(0, 99, "・レベルを上げ、装備を整えながらプレイしよう!", Font.new(20))

      #全体の操作
      Window.draw_font(0, 135, "全体の説明", Font.new(27))
      Window.draw_font(0, 170, "・WASDキーで移動、コマンド選択", Font.new(20))
      Window.draw_font(0, 195, "・ENTERキーで決定!", Font.new(20))

      #RPGモードの説明
      Window.draw_font(0, 235, "RPG", Font.new(27))
      Window.draw_font(0, 265, "・技を出し合い攻撃、相手のHPを0にしたら勝ち", Font.new(20))
      Window.draw_font(0, 285, "・じっくり考えて技を選んだり、アイテムを使ったりしよう", Font.new(20))

      #シューティングモードの説明
      Window.draw_font(0, 310, "シューティング", Font.new(27))
      Window.draw_font(0, 340, "・弾を打って相手のHPを削ろう。相手のHPを0にしたら勝ち!", Font.new(20))
      Window.draw_font(0, 360, "・jキーで進行方向にまっすぐな弾、kキーで相手を追いかける球", Font.new(20))

      #格闘モードの説明
      Window.draw_font(0, 385, "格闘", Font.new(27))
      Window.draw_font(0, 420, "・ジャンプしたり攻撃したりして、相手にダメージを与えよう", Font.new(20))
      Window.draw_font(0, 440, "・jキーで攻撃、wキーでジャンプ", Font.new(20))

      Window.draw_font(55, 555, "  戻る  ", Font.new(25))
    when 2
      case(@@set_m)
      when 0
        @@flag, @@set_m, @@skin_button, @@skip_button, @@back_button = Op_update.update_set(x, y)
        Sprite.draw([@@back_g_s, @@back_button, @@skin_button, @@skip_button])
  
        #描画
        Window.draw_font(0, 0, "=====設定=====", Font.new(50))
  
        Window.draw_font(0, 208, "スキンの変更", Font.new(40))
        Window.draw_font(443, 208, "変更", Font.new(30))\
  
        Window.draw_font(0, 308, "コメントスキップ", Font.new(40))
        Window.draw_font(443, 308, "変更", Font.new(30))
      when 1
        @@flag, @@set_m, @@skin_yuusya, @@skin_tako, @@skin_ika, @@back_button, num = Op_update.update_skin(x, y)
        if num != -1
          $player.skin = num
        end
        Sprite.draw([@@back_g_s, @@back_button, @@skin_yuusya, @@skin_ika, @@skin_tako])

        #描画
        Window.draw_font(0, 0, "=====スキン=====", Font.new(50))
        Window.draw_font(0, 50, "選択したいスキンのボタンを押してね", Font.new(30))

        Window.draw_font(225, 200, "勇者", Font.new(30))
        Window.draw_font(225, 300, "タコ", Font.new(30))
        Window.draw_font(225, 400, "イカ", Font.new(30))
      when 2
        @@flag, @@set_m, @@skip_on, @@skip_off, @@back_button, num = Op_update.update_comment(x, y)
        if num != -1
          $player.skip = num
        end

        Sprite.draw([@@back_g_s, @@back_button, @@skip_on, @@skip_off])

        #描画
        Window.draw_font(0, 0, "=====コメントスキップ=====", Font.new(50))
        Window.draw_font(0, 50, "会話の内容をスキップできます", Font.new(30))

        Window.draw_font(225, 250, "する", Font.new(30))
        Window.draw_font(225, 350, "しない", Font.new(30))
      end
      Window.draw_font(55, 555, "  戻る  ", Font.new(25))
    when 3
      da, l_d = Data.exist?
      4.times do |i|
        if da[i] != 0
          @@msg[i] = da[i]
          @@lv[i] = l_d[i]
        end
      end

      @@flag, @@data1_show, @@data2_show, @@data3_show, @@data4_show, @@back_button, err = Op_update.update_load(x, y)
      Sprite.draw([@@back_g_l, @@data1_show, @@data2_show, @@data3_show, @@data4_show, @@back_button])
      if err == 1
        Window.draw(200, 150, @@no_data)
      end

      Window.draw_font(50, 50, "DATA 1", Font.new(32), {color: C_BLACK})
      Window.draw_font(350, 50, "DATA 2", Font.new(32), {color: C_BLACK})
      Window.draw_font(50, 350, "DATA 3", Font.new(32), {color: C_BLACK})
      Window.draw_font(350, 350, "DATA 4", Font.new(32), {color: C_BLACK})
      Window.draw_font(55, 555, "  戻る  ", Font.new(25))
      
      Window.draw_font(75, 100, @@msg[0], Font.new(32), {color: C_BLACK})
      Window.draw_font(75, 132, @@lv[0], Font.new(32), {color: C_BLACK})

      Window.draw_font(375, 100, @@msg[1], Font.new(32), {color: C_BLACK})
      Window.draw_font(375, 132, @@lv[1], Font.new(32), {color: C_BLACK})

      Window.draw_font(75, 400, @@msg[2], Font.new(32), {color: C_BLACK})
      Window.draw_font(75, 432, @@lv[2], Font.new(32), {color: C_BLACK})

      Window.draw_font(375, 400, @@msg[3], Font.new(32), {color: C_BLACK})
      Window.draw_font(375, 432, @@lv[3], Font.new(32), {color: C_BLACK})
    when 4
      flag, name, num = Name_cho.name_sel
      @@flag, @@back_button = Op_update.update_name(x, y)
      Sprite.draw([@@back_g_n, @@back_button])

      Window.draw_font(0, 0, "名前を入力してね", Font.new(60))
      Window.draw_font(0, 60, "シフトを押して大文字/小文字を変えれるよ", Font.new(20))
      Window.draw_font(0, 100, "(現在:" + ((num == 0)? "小文字" : "大文字"), Font.new(30))
      Window.draw_font(50, 150, name, Font.new(32))
      Window.draw_font(50, 182, "━━━━━━━━━━━━━━━", Font.new(32))
      Window.draw_font(55, 555, "  戻る  ", Font.new(25))
    end

    if @@flag == 5
      @@flag = 0
      return 5
    else
      return @@flag
    end
    
  end
end