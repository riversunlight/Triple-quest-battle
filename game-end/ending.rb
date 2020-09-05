class Ending
  @@back_ground = Sprite.new(0, 0, Image.new(600, 600, C_BLACK))
  @@time = 0

  def self.draw
    Sprite.draw(@@back_ground)
    Window.draw_font(200, 600 - @@time, "トリプルクエストバトル", $font_40)
    Window.draw_font(100, 660 - @@time, "ゲーム案", $font_40)
    Window.draw_font(500 - "ABE".size * 40, 660 - @@time, "ABE", $font_40)
    Window.draw_font(100, 720 - @@time, "ゲーム制作", $font_40)
    Window.draw_font(500 - "ABE".size * 40, 720 - @@time, "ABE", $font_40)
    Window.draw_font(100, 780 - @@time, "クエストアイデア", $font_40)
    Window.draw_font(500 - "ABE".size * 40, 780 - @@time, "ABE", $font_40)
    Window.draw_font(100, 840 - @@time, "絵", $font_40)
    Window.draw_font(500 - "ABE".size * 40, 840 - @@time, "ABE", $font_40)
    Window.draw_font(100, 900 - @@time, "インターフェース", $font_40)
    Window.draw_font(500 - "ABE".size * 40, 900 - @@time, "ABE", $font_40)
    Window.draw_font(100, 1000 - @@time, "宿の朝の挨拶", $font_40)
    Window.draw_font(500 - "ABE".size * 40, 1000 - @@time, "ABE", $font_40)
    Window.draw_font(0, 1080, "ThanK You For Playing!", $font_40)
    @@time += 1
    if @@time >= 1100
      return 12
    end
    return 14
  end
end