pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
  tick=1
  b=make_bullet(64,64,50,0.01)
end

function _update()
  tick+=1
  if btn(4) then
    b=make_bullet(64,64,50,0.01)
  end
  b:update()
end

function _draw()
  cls()
  b:draw()
end
-->8
function sqr(x) return x*x end

function make_bullet(x,y,dst,r)
  return {
    show=true,
    sx=x,sy=y,x=x,y=y,dst=dst,
    dx=cos(r),dy=sin(r),
    mx=x+dst*cos(r),my=y+dst*sin(r),
    accel=2,tick=1,
    update=function(s)
      if not s.show then return end
      s.tick+=1
      local speed=s.accel/(s.tick/8)
      s.x+=s.dx*speed
      s.y+=s.dy*speed
      s.show=flr(sqrt(sqr(s.sx-s.x)+sqr(s.sy-s.y)))<s.dst
    end,
    draw=function(s)
      if not s.show then return end
      line(s.x,s.y,s.x,s.y,7)
      line(s.mx,s.my,s.mx,s.my,4)
    end
  }
end
