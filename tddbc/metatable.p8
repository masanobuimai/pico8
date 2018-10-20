pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
cn={}
function cn.new(b)
 local o={
  a=0,b=b,
 }
 setmetatable(o,cn)
 return o
end

function cn.__tostring(s)
 if s.b==0 then
  return "error"
 elseif abs(s.b)==1 then
  return s.b>0 and "i" or "-i"
 else
  return s.b.."i"
 end
end

function cn.__concat(a,b)
 if type(a)=="table" then a=cn.__tostring(a) end
 if type(b)=="table" then b=cn.__tostring(b) end
 return a..b
end
 
function cn.__eq(a,b)
 return a.a==b.a and a.b==b.b
end

a=cn.new(4)
b=cn.new(4)
c=cn.new(2)
print(a==b)
print(a==c)
print(a)
print(":"..a)