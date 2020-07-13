pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- coffee and donuts
-- by andrew edstrom

local player
local bones

function _init()
    player=make_player()
    bones={
        make_bone(75,20)
    }
end

function _update()
   player:update()
end

function _draw()
    cls(3)
    player:draw()
    for bone in all(bones) do
        bone:draw()
    end
end

function make_bone(x,y)
    return {
        x=x,
        y=y,
        width=6,
        height=6,
        update=function(self)

        end,
        draw=function(self)
            sspr(24,8,self.width,self.height,self.x,self.y,self.width,self.height)
        end
    }
end

function make_player()
    return {
        x=50,
        y=64,
        width=16,
        height=8,
        is_walking=false,
        is_facing_right=false,
        walk_timer=0,
        update=function(self)
            self.walk_timer+=1
            self.walk_timer%=8

            self.is_walking=false
            if btn(0) then 
                self.is_facing_right=false
                self.x-=1
                self.is_walking=true
            end
            if btn(1) then 
                self.is_facing_right=true
                self.x+=1
                self.is_walking=true
            end
            if btn(2) then 
                self.y-=1
            end
            if btn(3) then 
                self.y+=1
            end
        end,
        draw=function(self)
            local sprite_x = 8
            if self.is_walking then
                if self.walk_timer < 4 then
                    sprite_x = 24
                else
                    sprite_x = 40            
                end
            end
            sspr(sprite_x,0,self.width,self.height,self.x,self.y,self.width,self.height, self.is_facing_right)
        end
    }
end

__gfx__
00000000042200000000000004220000000000000422000000000000042200000000000004220000000000000000000000000000000000000000000000000000
00000000442240000000000044224000000000004422400000000000442240000000000044220000000000000000000000000000000000000000000000000000
00700700002244444444400000224444444440000022444444444000002244444444400000224000000000000000000000000000000000000000000000000000
00077000000444444444440000044444444444000004444444444400000444444444440000044444444400000000004040000040000000000000000000000000
00077000000444444444444000044444444444400004444444444440000444444444444000044444444444004000044440000444000000000000000000000000
00700700000044440000440400004444000044040000444400004404000044444000440400004440004440400444444004444440000000000000000000000000
00000000000004000000040400000400000040000000440000000400000040000000040000004000000040040444444004444440000000000000000000000000
00000000000044000000400000000040000400000004000000000040000400000000004000000000000000000400004004000400000000000000000000000000
00000000000007000000000000067500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000007700000675000067700000007000000070000000700000007000000000000000000000000000000000000000000000000000000000000000000
00000000000075000000677000675500000007700000677000000770000007700000000000000000000000000000000000000000000000000000000000000000
00000000000750000006755066750000000070000006750000007000000075500000000000000000000000000000000000000000000000000000000000000000
00000000077500000667500077500000007700000077500000770000000750000000000000000000000000000000000000000000000000000000000000000000
00000000007000006775000067500000000700000007000000770000077500000000000000000000000000000000000000000000000000000000000000000000
00000000000000000675000000000000000000000000000000000000057500000000000000000000000000000000000000000000000000000000000000000000
00000000000000000050000000000000000000000000000000000000055000000000000000000000000000000000000000000000000000000000000000000000
