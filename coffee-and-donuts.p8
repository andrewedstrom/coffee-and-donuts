pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- coffee and donuts
-- by andrew edstrom

local game_objects
local score

function _init()
    score=0
    game_objects={}
    make_dog()
    make_bone(40,50)
    make_bone(80,80)
end

function _update()
    for obj in all(game_objects) do
        obj:update()
    end
end

function _draw()
    cls(3)
    print(score,5,5,7)
    for obj in all(game_objects) do
        obj:draw()
    end
end

function make_bone(x,y)
    return make_game_object("bone",x,y,6,6,{
        eaten=false,
        update=function(self)
            foreach_game_object_of_kind("dog", function(dog)
                if not self.eaten and rects_overlapping(self.x,self.y,self.x+self.width,self.y+self.height,
                    dog.x,dog.y,dog.x+dog.width,dog.y+dog.height) then
                    sfx(0)
                    self.eaten=true
                    score+=1
                end
            end)
        end,
        draw=function(self)
            if not self.eaten then
                sspr(24,8,self.width,self.height,self.x,self.y,self.width,self.height)
            end
        end
    })
end

function make_dog()
    return make_game_object("dog",50,64,16,8,{
        is_walking=false,
        is_facing_right=false,
        walk_timer=0,
        was_eating_bone=false,
        update=function(self)
            self.walk_timer+=1
            self.walk_timer%=8

            self.is_walking=false
            if btn(0) then 
                self.is_facing_right=false
                self.x-=1
                self.is_walking=true
            elseif btn(1) then 
                self.is_facing_right=true
                self.x+=1
                self.is_walking=true
            end
            if btn(2) then 
                self.y-=1
                self.is_walking=true
            end
            if btn(3) then 
                self.y+=1
                self.is_walking=true
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
    })
end

function make_game_object(kind,x,y,width,height,props)
    local obj = {
        kind=kind,
        x=x,
        y=y,
        width=width,
        height=height,
        draw=function(self)
        end,
        update=function(self)
        end,
        draw_bounding_box=function(self,col)
            rect(self.x,self.y,self.x+self.width,self.y+self.height,col)
        end
    }

    -- add aditional object properties
    for k,v in pairs(props) do
        obj[k] = v
    end

    -- add new object to list of game objects
    add(game_objects, obj)
end

function lines_overlapping(l1,r1,l2,r2)
    return r1>l2 and r2>l1
end

function rects_overlapping(left1,top1,right1,bottom1,left2,top2,right2,bottom2)
    return lines_overlapping(left1,right1,left2,right2) and lines_overlapping(top1,bottom1,top2,bottom2)
end

function foreach_game_object_of_kind(kind, callback)
    local obj
    for obj in all(game_objects) do
        if obj.kind == kind then
            callback(obj)
        end
    end
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
__sfx__
0106000018050000001f0501f0401f0301f0200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
