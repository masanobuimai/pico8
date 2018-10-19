pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

function make_object(f)
  return {
    title="foo",
    result="unknown",
    update=f,
    draw=function(s)
      print(s.title..":"..s.result)
    end,
    assert=function(s,v)
      s.result=v and "success" or "failure"
    end
  }
end

function _init()
  p=make_object(function(s)
    s.title="hoge"
    s:assert(btn(4))
  end)
end

function _update()
  p:update()
end

function _draw()
  cls()
  p:draw()
end