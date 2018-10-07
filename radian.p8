pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

PI=3.14

function _init()
  deg=0
  r=0
  x,y=64,64
  vx,vy=0,0
  bullet=make_bullet(x,y,vx,vy)
  speed=2
end

function _update()
  if (btnp(up)) then deg+=10 end
  if (btnp(down)) then deg-=10 end
  if (btnp(right)) then speed+=1 end
  if (btnp(left)) then speed-=1 end
  if (speed < 1) then speed=1 end
  if (speed > 10) then speed=10 end
  deg=deg%360
  r=deg/360
  s,c=sin(r),cos(r)
  vx,vy=c*speed,s*speed
  x2 = x + (speed * 4) * c
  y2 = y + (speed * 4) * s
  if (btnp(fire1)) then bullet=make_bullet(x,y,vx,vy) end
  bullet:update()
end

function _draw()
  cls()
  print("deg:"..deg..",r:"..r,0,0,white)
  print("sin:"..s..",cos:"..c,0,8,white)
  print("speed:"..speed..",vx,vy:"..vx..","..vy,0,16,white)
  line(x,y,x2,y2,white)
  bullet:draw()
end

function make_bullet(x,y,vx,vy)
  local obj = {
    x=x,
    y=y,
    vx=vx,
    vy=vy,
    update=function(t)
      t.x+=t.vx
      t.y+=t.vy
      if (t.x < 0 or t.x > 128 or t.y < 0 or t.y > 128) then
        t.x,t.y=64,64
        t.vx,t.vy=0,0
      end
    end,
    draw=function(t)
      circfill(t.x,t.y,2,red)
      print("("..t.x..","..t.y..")("..t.vx..","..t.vy..")",0,123,white)
    end
  }
  return obj
end