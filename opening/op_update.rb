require 'dxruby'
require_relative 'name_cho'
require_relative '../data/data'

class Op_update
  #ルール用
  @@m_k_f_r = 0

  #ロード用
  @@m_k_f_l = 0
  @@sel_x_l = 0
  @@sel_y_l = 0
  @@err_sa = 0

  #設定用
  @@m_k_f_s = 0
  @@sel_s = 0

  #設定(スキン用)
  @@m_k_f_skin = 0
  @@sel_skin = 0

  #設定(コメント用)
  @@m_k_f_comm = 0
  @@sel_comm = 0

  #名前変更用
  @@m_k_f_n = 0
  @@sel_x_n = 0
  @@sel_x_n = 0

  #もし、アルファベットのもじが打たれたら真を返すメソッド
  def self.AnyKey_push?
    if Input.key_push?(K_A) || Input.key_push?(K_B) || Input.key_push?(K_C) || Input.key_push?(K_D) || Input.key_push?(K_E) || Input.key_push?(K_F) || Input.key_push?(K_G) || Input.key_push?(K_H) || Input.key_push?(K_I) || Input.key_push?(K_J) || Input.key_push?(K_K) || Input.key_push?(K_L) || Input.key_push?(K_M) || Input.key_push?(K_N) || Input.key_push?(K_O) || Input.key_push?(K_P) || Input.key_push?(K_Q) || Input.key_push?(K_R) || Input.key_push?(K_S) || Input.key_push?(K_T) || Input.key_push?(K_U) || Input.key_push?(K_V) || Input.key_push?(K_W) || Input.key_push?(K_X) || Input.key_push?(K_Y) || Input.key_push?(K_Z)
      return true
    else
      return false
    end
  end

  #ルール
  def self.update_ru_re(x, y)
    back_button = Sprite.new(50, 550, Image.new(100, 40, C_BLUE))
    if @@m_k_f_r == 0
      if Op_update.AnyKey_push?
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
        @@m_k_f_r = 1
        return 1, back_button
      end
      if x >= 50 && x <= 150 && y >= 550 && y <= 590
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
        if (Input.mouse_push?(M_LBUTTON))
          return 0, back_button
        else
          return 1, back_button
        end
      end
      return 1, back_button
    else
      if x >= 50 && x <= 150 && y >= 550 && y <= 590
        @@m_k_f_r = 0
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
        return 1, back_button
      end
      if Input.key_push?(K_RETURN)
        @@m_k_f_r = 0
        return 0, back_button
      else
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
        return 1, back_button
      end
    end
  end

  #設定
  def self.update_set(x, y)
    #ボタン(copy)
    skin_button = Sprite.new(400, 200, Image.new(150, 50, C_BLUE))
    skip_button = Sprite.new(400, 300, Image.new(150, 50, C_BLUE))
    back_button = Sprite.new(50, 550, Image.new(100, 40, C_BLUE))

    m = Sprite.new(x, y, Image.new(1, 1, C_RED))
    if @@m_k_f_s == 0
      if Op_update.AnyKey_push?
        @@m_k_f_s = 1
        @@sel_s = 0
        skin_button = Sprite.new(400, 200, Image.new(150, 50, C_RED))
        return 2, 0, skin_button, skip_button, back_button
      end

      #戻る
      if m === back_button && Input.mouse_push?(M_LBUTTON)
        return 0, 0, skip_button, skip_button, back_button
      end
      if m === skin_button && Input.mouse_push?(M_LBUTTON)
        return 2, 1, skip_button, skip_button, back_button
      end
      if m === skip_button && Input.mouse_push?(M_LBUTTON)
        return 2, 2, skip_button, skip_button, back_button
      end

      #オーバーされているものを赤く
      if m === skin_button
        skin_button = Sprite.new(400, 200, Image.new(150, 50, C_RED))
      end
      if m === skip_button
        skip_button = Sprite.new(400, 300, Image.new(150, 50, C_RED))
      end
      if m === back_button
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end

      return 2, 0, skin_button, skip_button, back_button
    else
      if m === skin_button || m === skip_button || m === back_button
        @@m_k_f_s = 0
        @@sel_s = 0
        return 2, 0, skin_button, skip_button, back_button
      end

      #選択しているものの操作
      if Input.key_push?(K_W)
        @@sel_s -= 1
      end
      if Input.key_push?(K_S)
        @@sel_s += 1
      end
      @@sel_s = (@@sel_s + 3) % 3

      if Input.key_push?(K_RETURN)
        @@m_k_f_s = 0
        case(@@sel_s)
        when 0
          return 2, 1, skin_button, skip_button, back_button
        when 1
          return 2, 2, skin_button, skip_button, back_button
        when 2
          return 0, 0, skin_button, skip_button, back_button
        end
      end

      #色を変えるやつ
      case(@@sel_s)
      when 0
        skin_button = Sprite.new(400, 200, Image.new(150, 50, C_RED))
      when 1
        skip_button = Sprite.new(400, 300, Image.new(150, 50, C_RED))
      when 2
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end

      return 2, 0, skin_button, skip_button, back_button
    end
  end

  #設定(スキン)
  def self.update_skin(x, y)
    #ボタン(copy)
    skin_yuusya = Sprite.new(225, 200, Image.new(150, 50, C_BLUE))
    skin_tako = Sprite.new(225, 300, Image.new(150, 50, C_BLUE))
    skin_ika = Sprite.new(225, 400, Image.new(150, 50, C_BLUE))
    back_button = Sprite.new(50, 550, Image.new(100, 40, C_BLUE))
    
    m = Sprite.new(x, y, Image.new(1, 1, C_RED))
    if @@m_k_f_skin == 0
      if Op_update.AnyKey_push?
        @@m_k_f_skin = 1
      end

      if Input.mouse_push?(M_LBUTTON)
        if m === skin_yuusya
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, 0
        end
        if m === skin_tako
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, 1
        end
        if m === skin_ika
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, 2
        end
        if m === back_button
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, -1
        end
      end

      if m === skin_yuusya
        skin_yuusya = Sprite.new(225, 200, Image.new(150, 50, C_RED))
      end
      if m === skin_tako
        skin_tako = Sprite.new(225, 300, Image.new(150, 50, C_RED))
      end
      if m === skin_ika
        skin_ika = Sprite.new(225, 400, Image.new(150, 50, C_RED))
      end
      if m === back_button
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end

      return 2, 1, skin_yuusya, skin_tako, skin_ika, back_button, -1
    else
      if m === skin_yuusya || m === skin_tako || m === skin_ika || m === back_button
        @@m_k_f_skin = 0
      end

      #Enterキーによる決定
      if Input.key_push?(K_RETURN)
        @@m_k_f_skin = 0
        case(@@sel_skin)
        when 0
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, 0
        when 1
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, 1
        when 2
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, 2
        when 3
          return 2, 0, skin_yuusya, skin_tako, skin_ika, back_button, -1
        end
      end

      #操作
      if Input.key_push?(K_W)
        @@sel_skin -= 1
      end
      if Input.key_push?(K_S)
        @@sel_skin += 1
      end
      @@sel_skin = (@@sel_skin + 4) % 4

      #赤く染める
      case(@@sel_skin)
      when 0
        skin_yuusya = Sprite.new(225, 200, Image.new(150, 50, C_RED))
      when 1
        skin_tako = Sprite.new(225, 300, Image.new(150, 50, C_RED))
      when 2
        skin_ika = Sprite.new(225, 400, Image.new(150, 50, C_RED))
      when 3
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end

      return 2, 1, skin_yuusya, skin_tako, skin_ika, back_button, -1
    end
  end

  #設定(コメントスキップ)
  def self.update_comment(x, y)
    #ボタン(copy)
    skip_on = Sprite.new(225, 250, Image.new(150, 50, C_BLUE))
    skip_off = Sprite.new(225, 350, Image.new(150, 50, C_BLUE))
    back_button = Sprite.new(50, 550, Image.new(100, 40, C_BLUE))

    #マウス
    m = Sprite.new(x, y, Image.new(1, 1, C_RED))
    if @@m_k_f_comm == 0
      if Op_update.AnyKey_push?
        @@m_k_f_comm = 1
      end

      #クリックされたら
      if Input.mouse_push?(M_LBUTTON)
        if m === skip_on
          return 2, 0, skip_on, skip_off, back_button, 1
        end
        if m === skip_off
          return 2, 0, skip_on, skip_off, back_button, 0
        end
        if m === back_button
          return 2, 0, skip_on, skip_off, back_button, -1
        end
      end

      #赤く染める
      if m === skip_on
        skip_on = Sprite.new(225, 250, Image.new(150, 50, C_RED))
      end
      if m === skip_off
        skip_off = Sprite.new(225, 350, Image.new(150, 50, C_RED))
      end
      if m === back_button
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end

      return 2, 2, skip_on, skip_off, back_button, -1
    else
      if m === skip_on || m === skip_off || m === back_button
        @@m_k_f_comm = 0
      end

      #選択されているものを赤く染める
      case(@@sel_comm)
      when 0
        skip_on = Sprite.new(225, 250, Image.new(150, 50, C_RED))
      when 1
        skip_off = Sprite.new(225, 350, Image.new(150, 50, C_RED))
      when 2
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end

      #エンターキーが押されたら
      if Input.key_push?(K_RETURN)
        case(@@sel_comm)
        when 0
          return 2, 0, skip_on, skip_off, back_button, 1
        when 1
          return 2, 0, skip_on, skip_off, back_button, 0
        when 2
          return 2, 0, skip_on, skip_off, back_button, -1
        end
      end

      #操作
      if Input.key_push?(K_W)
        @@sel_comm -= 1
      end
      if Input.key_push?(K_S)
        @@sel_comm += 1
      end
      @@sel_comm = (@@sel_comm + 3) % 3

      return 2, 2, skip_on, skip_off, back_button, -1
    end
  end

  #読み込み
  def self.update_load(x, y)
    #ボタン(copy)
    data1_show = Sprite.new(50, 50, Image.new(200, 200, C_WHITE))
    data2_show = Sprite.new(350, 50, Image.new(200, 200, C_WHITE))
    data3_show = Sprite.new(50, 350, Image.new(200, 200, C_WHITE))
    data4_show = Sprite.new(350, 350, Image.new(200, 200, C_WHITE))
    back_button = Sprite.new(50, 550, Image.new(100, 40, C_BLUE))

    m = Sprite.new(x, y, Image.new(1, 1, C_RED))
    if @@m_k_f_l == 0
      if Op_update.AnyKey_push?
        @@m_k_f_l = 1
        @@sel_x_l = 0
        @@sel_x_y = 0
        data1_show = Sprite.new(50, 50, Image.new(200, 200, C_RED))
        @@err_sa = 0
        return 3, data1_show, data2_show, data3_show, data4_show, back_button
      end

      if m === data1_show
        data1_show = Sprite.new(50, 50, Image.new(200, 200, C_RED))
      end
      if m === data2_show
        data2_show = Sprite.new(350, 50, Image.new(200, 200, C_RED))
      end
      if m === data3_show
        data3_show = Sprite.new(50, 350, Image.new(200, 200, C_RED))
      end
      if m === data4_show
        data4_show = Sprite.new(350, 350, Image.new(200, 200, C_RED))
      end
      if m === back_button
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end

      #遷移
      if Input.mouse_push?(M_LBUTTON)
        @@err_sa = 0
        if m === back_button
          return 0, data1_show, data2_show, data3_show, data4_show, back_button
        elsif m === data1_show
          if File.exist?("data/data0.txt")
            Data.read(0)
            return 5, data1_show, data2_show, data3_show, data4_show, back_button, 0
          else
            @err_sa = 1
            return 3, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
          end
        elsif m === data2_show
          if File.exist?("data/data1.txt")
            Data.read(1)
            return 5, data1_show, data2_show, data3_show, data4_show, back_button, 0
          else
            @@err_sa = 1
            return 3, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
          end
        elsif m === data3_show
          if File.exist?("data/data2.txt")
            Data.read(2)
            return 5, data1_show, data2_show, data3_show, data4_show, back_button, 0
          else
            @@err_sa = 1
            return 3, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
          end
        elsif m === data4_show
          if File.exist?("data/data3.txt")
            Data.read(3)
            return 5, data1_show, data2_show, data3_show, data4_show, back_button, 0
          else
            @@err_sa = 1
            return 3, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
          end
        else
          return 3, data1_show, data2_show, data3_show, data4_show, back_button, 0
        end
      end

      return 3, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
    else
      if m === data1_show || m === data2_show || m === data3_show || m === data4_show || m === back_button
        @@m_k_f_l = 0
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
        return 3, data1_show, data2_show, data3_show, data4_show, back_button, 0
      end
      
      if Input.key_push?(K_W)
        @@err_sa = 0
        @@sel_y_l -= 1
      end
      if Input.key_push?(K_A)
        @@err_sa = 0
        @@sel_x_l -= 1
      end
      if Input.key_push?(K_S)
        @@err_sa = 0
        @@sel_y_l += 1
      end
      if Input.key_push?(K_D)
        @@err_sa = 0
        @@sel_x_l += 1
      end

      @@sel_x_l = (@@sel_x_l + 2) % 2

      if @@sel_x_l == 0
        @@sel_y_l = (@@sel_y_l + 3) % 3
      else
        @@sel_y_l = (@@sel_y_l + 2) % 2
      end

      if @@sel_y_l == 2
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      elsif @@sel_x_l == 0 && @@sel_y_l == 0
        data1_show = Sprite.new(50, 50, Image.new(200, 200, C_RED))
      elsif @@sel_x_l == 1 && @@sel_y_l == 0
        data2_show = Sprite.new(350, 50, Image.new(200, 200, C_RED))
      elsif @@sel_x_l == 0 && @@sel_y_l == 1
        data3_show = Sprite.new(50, 350, Image.new(200, 200, C_RED))
      elsif @@sel_x_l == 1 && @@sel_y_l == 1
        data4_show = Sprite.new(350, 350, Image.new(200, 200, C_RED))
      end

      if Input.key_push?(K_RETURN)
        @@err_sa = 0
        @@m_k_f_l = 0
        if @@sel_y_l == 2
          return 0, data1_show, data2_show, data3_show, data4_show, back_button
        else
          if @@sel_x_l == 0 && @@sel_y_l == 0
            if File.exist?("data/data0.txt")
              Data.read(0)
            else
              @@err_sa = 1
            end
          elsif @@sel_x_l == 1 && @@sel_y_l == 0
            if File.exist?("data/data1.txt")
              Data.read(1)
            else
              @@err_sa = 1
            end
          elsif @@sel_x_l == 0 && @@sel_y_l == 1
            if File.exist?("data/data2.txt")
              Data.read(2)
            else
              @@err_sa = 1
            end
          elsif @@sel_x_l == 1 && @@sel_y_l == 1
            if File.exist?("data/data3.txt")
              Data.read(3)
            else
              @@err_sa = 1
            end
          end
          if @@err_sa == 0
            return 5, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
          else
            return 3, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
          end
        end
      end
      return 3, data1_show, data2_show, data3_show, data4_show, back_button, @@err_sa
    end
  end

  #名前入力
  def self.update_name(x, y)
    if Op_update.AnyKey_push?
      @@m_k_f_n = 0
    end
    m = Sprite.new(x, y, Image.new(1, 1, C_RED))
    back_button = Sprite.new(50, 550, Image.new(100, 40, C_BLUE))
    if @@m_k_f_n == 0

      if Input.key_push?(K_ESCAPE)
        @@m_k_f_n = 1
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end
      if Input.key_push?(K_RETURN)
        @@m_k_f_n  = 0
        return 5, back_button
      end

      if m === back_button
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
        if Input.mouse_push?(M_LBUTTON)
          return 0, back_button
        end
      end
      
    else
      if m === back_button
        @@m_k_f_n = 0
        back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
      end
      if Input.key_push?(K_RETURN)
        if @@m_k_f_n == 1
          @@m_k_f_n = 0
          return 0, back_button
        else
          return 5, back_button
        end
      end

      back_button = Sprite.new(50, 550, Image.new(100, 40, C_RED))
    end

    return 4, back_button
  end
end