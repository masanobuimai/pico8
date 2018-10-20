pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function make_cn(b)
 return {
  a=0,b=b,
  notation=function(s)
   if s.b==0 then
    return "error"
   elseif abs(s.b)==1 then
    return s.b>0 and "i" or "-i"
   else
    return s.b.."i"
   end
  end,
  equals=function(s,a)
   return s.a==a.a and s.b==a.b
  end
 }
end

-->8
function add_test(t)
 add(suite,{
  run=false,
  messages={},
  assert_eq=function(s,a,b)
   run=true
   if a~=b then 
    add(s.messages,"failure:"..a.." is not "..b)
   end
  end,
  assert_true=function(s,f)
   run=true
   if not f then
    add(s.messages,"failure:")
   end
  end,
  result=function(s)
   if not run then
    color(6)
    print("no assert")
   else
    if #s.messages==0 then
     color(11)
     print("success")
    else
     color(8)
     for s in all(s.messages) do print(s) end
    end
   end
  end,
  test=t
 })
end

-->8
suite={}
add_test(function(s)
 s:assert_eq(make_cn(1):notation(),"i")
 s:assert_eq(make_cn(-1):notation(),"-i")
end)
add_test(function(s)
 s:assert_eq(make_cn(4):notation(),"4i")
end)
add_test(function(s)
 s:assert_eq(make_cn(0):notation(),"error")
end)
add_test(function(s)
 s:assert_true(make_cn(4):equals(make_cn(4)))
 s:assert_true(not make_cn(4):equals(make_cn(2)))
end)
for t in all(suite) do t:test() end
for t in all(suite) do t:result() end