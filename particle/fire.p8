pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
fires={}
function _init()
  tick=1
end

function _update()
  if btnp(4) then
    add(fires,make_fire(rnd(128),rnd(128),30*rnd(1)))
  end
  for v in all(fires) do
    v:update()
    if not v:show() then del(fires,v) end
  end
end

function _draw()
  cls()
  for v in all(fires) do
    v:draw()
  end
end
-->8
function sqr(x) return x*x end

function make_fire(x,y,dst)
  local f={
    bullets={},
    update=function(s)
      for v in all(s.bullets) do
        v:update()
      end
    end,
    draw=function(s)
      for v in all(s.bullets) do
        v:draw()
      end
    end,
    show=function(s)
      local f=false
      for v in all(s.bullets) do
        if v.show then f=true end
      end
      return f
    end
  }
  for i=0,15 do
    f.bullets[i]=make_bullet(x,y,
                             20+dst,
                             rnd(1))
  end
  return f
end

function make_bullet(x,y,dst,r)
  return {
    show=true,
    sx=x,sy=y,x=x,y=y,dst=dst,
    dx=cos(r),dy=sin(r),
    mx=x+dst*cos(r),my=y+dst*sin(r),
    accel=1.5,tick=1,tick_base=7.5,
    update=function(s)
      if not s.show then return end
      s.tick+=1
      local speed=s.accel/(s.tick/s.tick_base)
      s.x+=s.dx*speed
      s.y+=s.dy*speed
      s.show=flr(sqrt(sqr(s.sx-s.x)+sqr(s.sy-s.y)))<s.dst
    end,
    draw=function(s)
      if not s.show then return end
--      line(s.x,s.y,s.x,s.y,7)
      circfill(s.x,s.y,1,7)
    end
  }
end
