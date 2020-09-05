class Name_cho
  @@name = ''
  @@ch_f = 0

  def self.name_sel
    #特殊な文字の対応
    if Input.key_push?(K_BACKSPACE)
      if @@name.size != 0
        @@name.chop!
      end
    end
    if Input.key_push?(K_RETURN)
      $player.name= @@name
      @@name = ""
      return 1, @@name, @@ch_f
    end
    if Input.key_push?(K_LSHIFT) || Input.key_push?(K_RSHIFT)
      @@ch_f += 1
      @@ch_f %= 2
    end

    #通常の文字の対応
    if @@name.size <= 33
      if Input.key_push?(K_A)
        if @@ch_f == 1
          @@name += "A"
        else
          @@name += "a"
        end
      end
      if Input.key_push?(K_B)
        if @@ch_f == 1
          @@name += "B"
        else
          @@name += "b"
        end
      end
      if Input.key_push?(K_C)
        if @@ch_f == 1
          @@name += "C"
        else
          @@name += "c"
        end
      end
      if Input.key_push?(K_D)
        if @@ch_f == 1
          @@name += "D"
        else
          @@name += "d"
        end
      end
      if Input.key_push?(K_E)
        if @@ch_f == 1
          @@name += "E"
        else
          @@name += "e"
        end
      end
      if Input.key_push?(K_F)
        if @@ch_f == 1
          @@name += "F"
        else
          @@name += "f"
        end
      end
      if Input.key_push?(K_G)
        if @@ch_f == 1
          @@name += "G"
        else
          @@name += "g"
        end
      end
      if Input.key_push?(K_H)
        if @@ch_f == 1
          @@name += "H"
        else
          @@name += "h"
        end
      end
      if Input.key_push?(K_I)
        if @@ch_f == 1
          @@name += "I"
        else
          @@name += "i"
        end
      end
      if Input.key_push?(K_J)
        if @@ch_f == 1
          @@name += "J"
        else
          @@name += "j"
        end
      end
      if Input.key_push?(K_K)
        if @@ch_f == 1
          @@name += "K"
        else
          @@name += "k"
        end
      end
      if Input.key_push?(K_L)
        if @@ch_f == 1
          @@name += "L"
        else
          @@name += "l"
        end
      end
      if Input.key_push?(K_M)
        if @@ch_f == 1
          @@name += "M"
        else
          @@name += "m"
        end
      end
      if Input.key_push?(K_N)
        if @@ch_f == 1
          @@name += "N"
        else
          @@name += "n"
        end
      end
      if Input.key_push?(K_O)
        if @@ch_f == 1
          @@name += "O"
        else
          @@name += "o"
        end
      end
      if Input.key_push?(K_P)
        if @@ch_f == 1
          @@name += "P"
        else
          @@name += "p"
        end
      end
      if Input.key_push?(K_Q)
        if @@ch_f == 1
          @@name += "Q"
        else
          @@name += "q"
        end
      end
      if Input.key_push?(K_R)
        if @@ch_f == 1
          @@name += "R"
        else
          @@name += "r"
        end
      end
      if Input.key_push?(K_S)
        if @@ch_f == 1
          @@name += "S"
        else
          @@name += "s"
        end
      end
      if Input.key_push?(K_T)
        if @@ch_f == 1
          @@name += "T"
        else
          @@name += "t"
        end
      end
      if Input.key_push?(K_U)
        if @@ch_f == 1
          @@name += "U"
        else
          @@name += "u"
        end
      end
      if Input.key_push?(K_V)
        if @@ch_f == 1
          @@name += "V"
        else
          @@name += "v"
        end
      end
      if Input.key_push?(K_W)
        if @@ch_f == 1
          @@name += "W"
        else
          @@name += "w"
        end
      end
      if Input.key_push?(K_X)
        if @@ch_f == 1
          @@name += "X"
        else
          @@name += "x"
        end
      end
      if Input.key_push?(K_Y)
        if @@ch_f == 1
          @@name += "Y"
        else
          @@name += "y"
        end
      end
      if Input.key_push?(K_Z)
        if @@ch_f == 1
          @@name += "Z"
        else
          @@name += "z"
        end
      end
    end

    return 0, @@name, @@ch_f
  end
end