require 'dxruby'
require_relative 'chara_state/player'

#プレイヤの宣言(グローバル)(ここじゃないとエラーになります)
$player = Player.new

require_relative 'opening/opening'
require_relative 'game-end/ending.rb'
require_relative 'game-end/gameover.rb'
require_relative 'game-end/gameclear.rb'
require_relative 'quest/park'
require_relative 'quest/quest/f_q'
require_relative 'quest/quest/fire_m'
require_relative 'quest/quest/cold_sea'
require_relative 'quest/quest/beast_fore'
require_relative 'quest/quest/trad_rpg'
require_relative 'quest/quest/sho_battle'
require_relative 'quest/quest/k_p'
require_relative 'quest/quest/prev_uirusu'
require_relative 'quest/quest/kadai'
require_relative 'quest/quest/p_language'
require_relative 'quest/quest/bakemono'

#ウインドウ設定
Window.width = 600
Window.height = 600
Window.caption = "トリプルクエストバトル"

#便利上の都合のグローバル変数
$font_20 = Font.new(20)
$font_30 = Font.new(30)
$font_40 = Font.new(40)

#メインループ
flag = 0
#ゲーム本体
num = -1
ch = num
Park.chenge = 0
Window.loop do
  #クエストまたは広場への遷移
  if ch != num && num == -1
    $player = Player.new
  end
  ch = num
  case(num)
  when -1
    obj = Opening.new
    flag = obj.draw
    if flag == 5
      num = 0
      flag = 0
    end
  when 0
    Park.move
    num = Park.draw
  when 1
    F_q.move
    num = F_q.draw
  when 2
    Fire_m.move
    num = Fire_m.draw
  when 3
    Cold_sea.move
    num = Cold_sea.draw
  when 4
    Beast_fore.move
    num = Beast_fore.draw
  when 5
    Trad_rpg.move
    num = Trad_rpg.draw
  when 6
    Sho_battle.move
    num = Sho_battle.draw
  when 7
    K_p.move
    num = K_p.draw
  when 8
    Prev_uirusu.move
    num = Prev_uirusu.draw
  when 9
    Kadai.move
    num = Kadai.draw
  when 10
    P_language.move
    num = P_language.draw
  when 13
    Bakemono.move
    num = Bakemono.draw
  when 11
    Gameover.move
    num = Gameover.draw
  when 12
    Gameclear.move
    num = Gameclear.draw
  when 14
    num = Ending.draw
  end
end