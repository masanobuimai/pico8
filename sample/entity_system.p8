pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function _has(e, ks)
  for n in all(ks) do
    if not e[n] then
      return false
    end
  end
  return true
end

function system(ks, f)
  return function(es)
    for e in all(es) do
      if _has(e, ks) then
        f(e)
      end
    end
  end
end

world = {}

add(world,{pos={x=32,y=64},color=12})
add(world,{pos={x=64,y=64},sprite=0})
add(world,{pos={x=96,y=64},color=8,sprite=1})

circles = system({"pos","color"},
  function (e)
    circfill(e.pos.x,e.pos.y,8,e.color)
  end)

sprites = system({"pos","sprite"},
  function (e)
    spr(e.sprite, e.pos.x-4, e.pos.y-4)
  end)

function _draw()
  cls()
  circles(world)
  sprites(world)
end