pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

function _init()
  t=0
  w,h=16,16
  speed=1
end

function _update()
  t += 1
  r,s,c = (t*speed%100)/100, sin(r), cos(r)
  dx,dy = w * s, h * c
  if (btnp(up)) then speed+=1 end
  if (btnp(down)) then speed-=1 end
end

function _draw()
  cls()
  print(t.." "..speed.." "..r,0,0,white)
  print("sin():"..s,0,8,white)
  print("cos():"..c,0,16,white)

  x,y=16,40
  line(x+dx,y,x+dx,y,red)
  line(x,y+dy,x,y+dy,blue)
  line(x+32,y,x+32+dx,y+dy,yellow)

  x,y=80,40
  line(x+dy,y,x+dy,y,red)
  line(x,y+dx,x,y+dx,blue)
  line(x+32,y,x+32+dy,y+dx,yellow)

  x,y=16,72
  line(x+(1-dx),y,x+(1-dx),y,red)
  line(x,y+(1-dy),x,y+(1-dy),blue)
  line(x+32,y,x+32+(1-dx),y+(1-dy),yellow)

  x,y=80,72
  line(x+(1-dy),y,x+(1-dy),y,red)
  line(x,y+(1-dx),x,y+(1-dx),blue)
  line(x+32,y,x+32+(1-dy),y+(1-dx),yellow)
end
