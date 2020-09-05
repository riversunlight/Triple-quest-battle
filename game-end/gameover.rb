class Gameover
  @@back_ground = Image.load('image/GAMEOVER.png')
  @@color = [C_BLUE, C_RED]

  @@c_n_con = 0
  @@c_n_end = 0
  @@sel = 0
  @@change = 11
  @@m_k = 0
  @@continue_button = Sprite.new(200, 150, Image.new(200, 80, @@color[@@c_n_con]))
  @@end_button = Sprite.new(200, 150, Image.new(200, 80, @@color[@@c_n_end]))
  
  def self.move
    @@c_n_con = 0
    @@c_n_end = 0
    m = Sprite.new(Input.mouse_pos_x, Input.mouse_pos_y, Image.new(1, 1, C_RED))
    if @@m_k == 0
      if Op_update.AnyKey_push?
        @@m_k = 1
        @@sel = 0
      end

      if m === @@continue_button
        @@c_n_con = 1
      end
      if m === @@end_button
        @@c_n_end = 1
      end
      if Input.mouse_down?(M_LBUTTON)
        if m === @@continue_button
          @@change = 0
        elsif m === @@end_button
          @@change = -1
        end
      end
    else
      if m === @@continue_button || m === @@end_button
        @@m_k = 0
      end

      if Input.key_push?(K_W)
        @@sel -= 1
      end
      if Input.key_push?(K_S)
        @@sel += 1
      end
      @@sel = (@@sel + 2) % 2
      if @@sel == 0
        @@c_n_con = 1
      end
      if @@sel == 1
        @@c_n_end = 1
      end
      if Input.key_push?(K_RETURN)
        case(@@sel)
        when 0
          @@change = 0
        when 1
          @@change = -1
        end
      end
    end
  end

  def self.draw
    Window.draw(0, 0, @@back_ground)

    @@continue_button = Sprite.new(190, 350, Image.new(220, 80, @@color[@@c_n_con]))
    @@end_button = Sprite.new(190, 450, Image.new(220, 80, @@color[@@c_n_end]))
    Sprite.draw([@@continue_button, @@end_button])
    Window.draw_font(225, 375, "広場へ戻る", $font_30)
    Window.draw_font(195, 475, "タイトルへ戻る", $font_30)

    case(@@sel)
    when 0
      Window.draw_font(10, 540, "HPを1まで回復し、お金はクエストに行く前に", $font_20)
      Window.draw_font(10, 570, "戻ります", $font_20)
    when 1
      Window.draw_font(10, 540, "最後にセーブしてから上がったレベルや購入したアイテムのデータは", $font_20)
      Window.draw_font(10, 570, "破棄されます", $font_20)
    end
    if @@change != 11
      num = @@change
      @@sel = 0
      @@c_n_con = 0
      @@c_n_end = 0
      @@change = 11
      $player.effect_reset
      case(num)
      when 0
        $player.hp = 1
      when -1
        $player = Player.new
      end
      $player.effect_reset
      return num
    else
      return @@change
    end
  end
end