-- 基础设置
-- 罗技鼠标dpi为800，穿越火线内设置速度为12
-- 左键 = 1
-- 右键 = 2
-- 滚轮单击 = 3
-- 左上 = 5
-- 左下 = 4
-- 左上上=6
-- 左前（调dpi）= 8
-- 左后（调dpi）= 7
-- 滚轮的下下 = 9 
-- 使用哪个就将0改为对应数字即可，关闭为0
local jump_box = 9  -- 一键上箱开关
local ghost_jump = 5 -- 鬼跳开关
local usp_fire = 4 -- usp连发
local lei_shen_san_lian_fa = 8 -- 雷神三连发开关
local force_gun_leishen = 0 -- 雷神压枪开关

-- 属性设置，不更改为默认
local change_gun = 1 -- 瞬狙之后是否切枪（1为切枪，0为不切）
local usp_speed = 33 -- usp速度，默认20毫秒起步
local usp_push_gun = false -- usp是否压枪，true为压枪，false为否，按习惯来

-- 启用鼠标左键监测事件
EnablePrimaryMouseButtonEvents(true)

-- 入口方法
function OnEvent(event, arg)

    -- 一键上箱1.0
    if (event == "MOUSE_BUTTON_PRESSED" and arg == jump_box) then
        PressKey("spacebar")
        Sleep(math.random(267, 275))
        ReleaseKey("spacebar")
        Sleep(math.random(346, 354))
        PressKey("spacebar")
        Sleep(math.random(164, 172))
        ReleaseKey("spacebar")
        Sleep(math.random(96, 104))
        PressKey("lctrl")
        Sleep(math.random(140, 148))
        ReleaseKey("lctrl")
    end

    -- 鬼跳（按住ctrl+方向键+侧键）
    -- if (event == "MOUSE_BUTTON_PRESSED" and arg == ghost_jump ) then
    --   while(IsMouseButtonPressed(ghost_jump))
    --   do
    --     PressKey("spacebar")
    --     Sleep(math.random(8,11))                 
    --     ReleaseKey("spacebar")
    --     Sleep(math.random(8,11))
    --   end              
    -- end

    -- 鬼跳1.2(只需要按住方向键+侧键)(个人觉得没有自己按ctrl手感好)
    if (event == "MOUSE_BUTTON_PRESSED" and arg == ghost_jump) then
        while (IsMouseButtonPressed(ghost_jump)) do
            PressKey("spacebar")
            Sleep(math.random(5, 8))
            PressKey("lctrl")
            Sleep(math.random(1, 3))
            ReleaseKey("spacebar")
            Sleep(math.random(8, 11))
        end
        ReleaseKey("lctrl")
    end

    -- usp连发
    if (event == "MOUSE_BUTTON_PRESSED" and arg == usp_fire) then
        -- usp连发压枪
        time_sum = 0
        move_y = 0
        if (usp_push_gun) then
            move_y = 3
        end
        while (IsMouseButtonPressed(usp_fire)) do
            MoveMouseRelative(0, move_y)
            PressMouseButton(1)
            usp_speed_end = usp_speed + 10
            time_one = math.random(usp_speed, usp_speed_end)
            Sleep(time_one)
            ReleaseMouseButton(1)
            time_two = math.random(usp_speed, usp_speed_end)
            Sleep(time_two)
            time_sum = time_sum + time_one + time_two
            if (time_sum > 300) then
                move_y = 0
            end
        end
    end

    -- 雷神三连发
    if (event == "MOUSE_BUTTON_PRESSED" and arg == lei_shen_san_lian_fa) then
        -- 下面注意，判断是否按压的值和正在按压的值不同，分别是132和123value
        -- OutputLogMessage("Hello World %d\n",2007)
        PressMouseButton(1)
        Sleep(math.random(178, 190))
        ReleaseMouseButton(1)
        Sleep(math.random(45, 53))
    end

    -- 雷神连续3连发
    -- if (event == "MOUSE_BUTTON_PRESSED" and arg == lei_shen_san_lian_fa ) then
    --   -- 下面注意，判断是否按压的值和正在按压的值不同，分别是132和123value
    --   while(IsMouseButtonPressed(lei_shen_san_lian_fa))
    --   do
    --     --OutputLogMessage("Hello World %d\n",2007)
    --     PressMouseButton(1)
    --     Sleep(math.random(178,190))
    --     ReleaseMouseButton(1)
    --     Sleep(math.random(45,53))
    --   end  
    -- end

    -- 雷神压枪2.0 -左键和压强键一起按
    if (event == "MOUSE_BUTTON_PRESSED" and arg == force_gun_leishen) then
        move_y = 3 -- 纵向移动坐标
        move_x = 0 -- 横向移动坐标
        time_all = 0 -- 枪口停止压枪阀
        -- last_x_pos = 0  --上次的x坐标
        -- last_y_pos = 0  --上次的y坐标
        -- last_x_pos ,last_y_pos = GetMousePosition()
        -- 循环压枪
        while (IsMouseButtonPressed(force_gun_leishen)) do
            if (time_all < 60) then
                -- 前2发不压
                move_y = 0
            end
            time_one = math.random(7, 10)
            Sleep(time_one)
            MoveMouseRelative(move_x, move_y)
            time_two = math.random(7, 10)
            Sleep(time_two)
            time_all = time_all + time_one + time_two
            if (time_all > 360) then
                -- 达到压枪阈值纵坐标停止运动
                move_y = 0
                -- 横坐标开始运动
                current_x_pos, current_y_pos = GetMousePosition() -- 获取当前鼠标坐标
                -- 如果当前鼠标移动，自动像反方向压枪

            else
                move_y = 3
            end

        end
    end

end

