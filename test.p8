pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

local player={
  x=28,
  y=28,
  hw=4,   -- half width
  hh=4,   -- half height
  v=2,    -- velocity
  update=function(t)
    if (btn(0) and t.x - t.hw > 0) t.x-=t.v
    if (btn(1) and t.x + t.hw < 127) t.x+=t.v
    if (btn(2) and t.y - t.hh > 0) t.y-=t.v
    if (btn(3) and t.y + t.hh < 127) t.y+=t.v
  end,
  draw=function(t)
    circ(t.x,t.y,1,8)
    rect(t.x-t.hw,t.y-t.hh,t.x+t.hw,t.y+t.hh,7)
    print(t.x..":"..t.y, t.x-t.hw,t.y-t.hh-7,7)
  end
}

local center={
  x=64,
  y=64,
  draw=function(t)
    line(t.x-2,t.y,t.x+2,t.y,9)
    line(t.x,t.y-2,t.x,t.y+2,9)
  end
}

local info={
  x=0,
  y=0,
  dst=0,
  deg=0,
  color=5,
  fx=0,
  fy=0,
  update=function(t, a, b)
    dx = (a.x - b.x) ^ 2
    dy = (a.y - b.y) ^ 2
    t.dst = flr(sqrt(dx + dy))
    if (t.dst < 10) then
      t.color=8
    else
      t.color=5
    end
    t.x = (a.x + b.x) / 2  -- center x
    t.y = (a.y + b.y) / 2  -- center y
    t.deg = atan2(b.x-a.x,b.y-a.y)
    -- aからbの向きの90度側の，aとbの半分の距離の座標
    t.fx = a.x + (t.dst/2) * cos(t.deg+0.25)
    t.fy = a.y + (t.dst/2) * sin(t.deg+0.25)
  end,
  draw=function(t,a,b)
    line(a.x,a.y, b.x,b.y,t.color)
    line(a.x,a.y, t.fx,t.fy,8)
    print(t.dst.." "..flr(t.deg*360),t.x-4,t.y+1,7)
  end
}


function _update()
  info:update(player, center)
  player:update()
end

function _draw()
  cls()
  info:draw(player, center)
  center:draw()
  player:draw()
end
