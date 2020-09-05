class Gameclear
  @@sel = 0
  @@back_ground = Image.load('image/gameclear.png')
  @@chenge = 12

  def self.move
    if Op_update.AnyKey_push? || Input.key_push?(K_RETURN)
      @@chenge = 0
      $player.g_exp = 0
      $player.money = $player.money + $player.g_money
      $player.g_money = 0
      $player.k_monster = 0
      $player.effect_reset
    end
  end

  def self.draw
    Window.draw(0, 0, @@back_ground)

    #戦績表示
    Window.draw_font(5, 220, "獲得経験値: #{$player.state["g_exp"]}", $font_30)
    Window.draw_font(5, 250, "獲得金: #{$player.state["g_money"]}", $font_30)
    Window.draw_font(5, 280, "討伐数: #{$player.state["k_monster"]}", $font_30)

    Window.draw_font(600 - 30 * 16, 570, "Any Key Plese...", $font_30)
    if @@chenge != 12
      num = @@chenge
      @@sel = 0
      @@chenge = 12
      return num
    else
      return @@chenge
    end
  end
end