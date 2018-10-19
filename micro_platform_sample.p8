pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
floor_y=104

function _init()
--  ticks=0
  p1=make_player(64,0)
end

function _update()
--  ticks+=1
  p1:update()
end

function _draw()
  cls()
  line(0,floor_y,128,floor_y,3)
  p1:draw()
end

-->8
function make_player(x,y)
  return {
    x=x, y=y, w=8, h=8,
    dx=0, dy=0,
    max_dx=1, max_dy=2,
    jump_speed=-3.75,
    accel=0.05,
    deccel=0.8,
    air_deccel=1,grav=0.15,
    jump_button={
      update=function(s)
        s.is_pressed=false
        if btn(up) then
          if not s.is_down then
            s.is_pressed=true
          end
          s.is_down=true
          s.ticks_down+=1
        else
          s.is_down=false
          s.is_pressed=false
          s.ticks_down=0
        end
      end,
      is_pressed=false,
      is_down=false,
      ticks_down=0
    },
    jump_hold_time=0,
    min_jump_press=5,max_jump_press=20,
    jump_btn_released=true,
    grounded=false,
    airtime=0,
    anims={
      ["stand"]={
        ticks=1,
        frames={2}
      },
      ["walk"]={
        ticks=5,
        frames={3,4,5,6}
      },
      ["dash"]={
        ticks=2,
        frames={7,8}
      },
      ["jump"]={
        ticks=1,
        frames={9}
      },
      ["slide"]={
        ticks=1,
        frames={10}
      },
    },
    curanim="walk",
    curframe=1,
    animtick=0,
    flipx=false,
    set_anim=function(s, anim)
      if (anim==s.curanim) return
      s.animtick=s.anims[anim].ticks
      s.curanim=anim
      s.curframe=1
    end,
    update=function(s)
      local leftb=btn(left)
      local rightb=btn(right)
      if leftb==true then
        s.dx-=s.accel
        rightb=false
      elseif rightb==true then
        s.dx+=s.accel
      else
        s.dx=s.dx*(s.grounded and s.deccel or s.air_deccel)
      end
      local cur_max=btn(fire1) and s.max_dx*2 or s.max_dx
      s.dx=mid(-cur_max,s.dx,cur_max)
      s.x+=s.dx

      s.jump_button:update()
      if s.jump_button.is_down then
        local on_ground=(s.grounded or s.airtime<5)
        local new_jump_btn=s.jump_button.ticks_down<10
        if s.jump_hold_time>0 or (on_ground and new_jump_btn) then
          s.jump_hold_time+=1
          if s.jump_hold_time<s.max_jump_press then
            s.dy=s.jump_speed
          end
        end
      else
        s.jump_hold_time=0
      end

      s.dy+=s.grav
      s.dy=mid(-s.max_dy,s.dy,s.max_dy)
      s.y+=s.dy

      if s.y<floor_y-(s.h/2) then
        s:set_anim("jump")
        s.grounded=false
        s.airtime+=1
      else
        s.dy=0
        s.y=(flr((s.y+(s.h/2))/8)*8)-(s.h/2)
        s.grounded=true
        s.airtime=0
      end

      if s.grounded then
        if rightb then
          s:set_anim(s.dx<0 and "slide"
                            or (abs(s.dx)>s.max_dx and "dash" or "walk"))
        elseif leftb then
          s:set_anim(s.dx>0 and "slide"
                            or (abs(s.dx)>s.max_dx and "dash" or "walk"))
        else
          s:set_anim("stand")
        end
      end

      s.flipx=rightb and false or (leftb and true or false)

      s.animtick-=1
      if s.animtick<=0 then
        s.curframe+=1
        local a=s.anims[s.curanim]
        s.animtick=a.ticks
        if s.curframe>#a.frames then
          s.curframe=1
        end
      end
    end,
    draw=function(s)
      local f=s.anims[s.curanim].frames[s.curframe]
      print(s.curanim..",a:"..s.animtick.."/"..s.anims[s.curanim].ticks
            ..",f:"..s.curframe..",dx:"..s.dx,0,0,white)
      rect(s.x-(s.w/2),s.y-(s.h/2),
           s.x+(s.w/2),s.y+(s.h/2),s.grounded and light_gray or yellow)
      print(f,s.x-(s.w/4),s.y-(s.h/4),white)
      rect(s.x,s.y,s.x,s.y,red)
    end
  }
end