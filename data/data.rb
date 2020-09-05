require_relative '../chara_state/player'
require_relative '../effect/weapon.rb'

class Data
  def self.exist?
    flag = [0, 0, 0, 0]
    lv = [0, 0, 0, 0]
    4.times do |i|
      if File.exist?("data/data#{i}.txt")
        File.open("data/data#{i}.txt", "r"){ |f|
        flag[i] = f.gets
        lv[i] = f.gets
        }
        
        flag[i] = "NAME: " + flag[i]
        lv[i] = "LV    : " + lv[i]
      end
    end

    return flag, lv
  end

  def self.read(num)
    File.open("data/data#{num}.txt", "r") {|f|
    $player.name = f.gets
    $player.lv = f.gets.to_i
    $player.money = f.gets.to_i
    if $player.check_skin == 0
      $player.skin = f.gets.to_i
    else
      num = f.gets.to_i
    end
    if $player.check_skip == 0
      $player.skip = f.gets.to_i
    else
      num = f.gets.to_i
    end
    $player.hp_max = f.gets.to_i
    $player.hp = f.gets.to_i
    $player.atack = f.gets.to_i
    $player.speed = f.gets.to_i
    $player.block = f.gets.to_i
    $player.k_fire = f.gets.to_i
    $player.k_water = f.gets.to_i
    $player.k_tree = f.gets.to_i
    $player.b_fire = f.gets.to_i
    $player.b_water = f.gets.to_i
    $player.b_tree = f.gets.to_i
    $player.r_mp_max = f.gets.to_i
    $player.r_mp = f.gets.to_i
    $player.r_mp_heal = f.gets.to_i
    $player.boal_s = f.gets.to_i
    $player.b_mp_max = f.gets.to_i
    $player.b_mp = f.gets.to_i
    $player.b_mp_heal = f.gets.to_i
    $player.jump = f.gets.to_i
    $player.stop = f.gets.to_i
    $player.p_r = f.gets.to_i
    $player.a_r = f.gets.to_i
    $player.item.size.times do |i|
      $player.item[i] = f.gets.to_i
    end
    $player.exp = f.gets.to_i
    str = ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r"]
    str.size.times do |i|
      $player.effect_add(str[i], f.gets.to_i)
    end
    str = ["head", "arm", "sord", "seald", "almor", "shoes", "amulet", "eye", "ear"]
    str.size.times do |i|
      num = f.gets.to_i
      if num != -1
        $player.equi_set(str[i], Weapon.menu(i)[num])
      end
    end
    $player.result.size.times do |i|
      $player.result_add2(i, f.gets.to_i)
    end
    num = f.gets.to_i
    num.times do |i|
      num2 = f.gets.to_i
      next if num2 == 0
      $player.waza_push($player.create_waza(num))
    end
    str = ["h_head", "h_arm", "h_sord", "h_seald", "h_armor", "h_shoes", "h_amulet", "h_eye", "h_ear"]
    str.size.times do |i|
      num = f.gets.to_i
      num.times do |j|
        num2 = f.gets.to_i
        $player.equi_push(str[i], Weapon.menu(i)[num2])
      end
    end
    }
    $player.erase_en
  end

  def self.write(num)
    File.open("data/data#{num}.txt", "w") {|f|
    f.write("#{$player.name}\n")
    f.write("#{$player.lv}\n")
    f.write("#{$player.money}\n")
    f.write("#{$player.skin}\n")
    f.write("#{$player.skip}\n")
    f.write("#{$player.hp_max}\n")
    f.write("#{$player.hp}\n")
    f.write("#{$player.atack_base}\n")
    f.write("#{$player.speed_base}\n")
    f.write("#{$player.block_base}\n")
    f.write("#{$player.k_fire_base}\n")
    f.write("#{$player.k_water_base}\n")
    f.write("#{$player.k_tree_base}\n")
    f.write("#{$player.b_fire_base}\n")
    f.write("#{$player.b_water_base}\n")
    f.write("#{$player.b_tree_base}\n")
    f.write("#{$player.r_mp_max}\n")
    f.write("#{$player.r_mp}\n")
    f.write("#{$player.r_mp_heal}\n")
    f.write("#{$player.boal_s}\n")
    f.write("#{$player.b_mp_max}\n")
    f.write("#{$player.b_mp}\n")
    f.write("#{$player.b_mp_heal}\n")
    f.write("#{$player.jump}\n")
    f.write("#{$player.stop}\n")
    f.write("#{$player.p_r_base}\n")
    f.write("#{$player.a_r_base}\n")
    $player.item.size.times do |i|
      f.write("#{$player.item[i]}\n")
    end
    f.write("#{$player.exp}\n")
    str = ["atack", "block", "speed", "k_fire", "k_water", "k_tree", "b_fire", "b_water", "b_tree", "p_r", "a_r"]
    str.size.times do |i|
      f.write("#{$player.effect[str[i]]}\n")
    end
    str = ["head", "arm", "sord", "seald", "armor", "shoes", "amulet", "eye", "ear"]
    str.size.times do |i|
      if $player.equi[str[i]] != 0
        f.write("#{$player.equi[str[i]]["num"]}\n")
      else
        f.write("-1\n")
      end
    end
    $player.result.size.times do |i|
      f.write("#{$player.result[i]}\n")
    end
    f.write("#{$player.waza.size}\n")
    $player.waza.size.times do |i|
      f.write("#{$player.waza[i]["num"]}\n")
    end
    str = ["h_head", "h_arm", "h_sord", "h_seald", "h_armor", "h_shoes", "h_amulet", "h_eye", "h_ear"]
    str.size.times do |i|
      f.write("#{$player.equi[str[i]].size}\n")
      $player.equi[str[i]].size.times do |j|
        f.write("#{$player.equi[str[i]][j]["num"]}\n")
      end
    end
    }
  end
end