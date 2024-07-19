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
local jump_box = 9 -- 一键上箱开关
local lianyu = 4


-- 属性设置，不更改为默认
local change_gun = 1 -- 瞬狙之后是否切枪（1为切枪，0为不切）
local usp_speed = 33 -- usp速度，默认20毫秒起步
local usp_push_gun = false -- usp是否压枪，true为压枪，false为否，按习惯来

-- 启用鼠标左键监测事件
EnablePrimaryMouseButtonEvents(true)

-- 公共函数 --------------------------------------------

-- 初始化随机种子（注意，罗技lua不支持os.time取随机数种子，但提供了GetDate函数）
math.randomseed(GetDate("%H%M%S"):reverse()) -- 由于lua底层使用C语言的LCG随机数算法，会导致相近种子产生的结果也相近，逆序即可避免此问题

-- 生成正态分布随机数的函数（使用Box-Muller变换）
function generate_normal_random(mean, stddev)
    -- 生成两个均匀分布的随机数（0到1之间）
    local u1 = math.random()
    local u2 = math.random()
    -- 使用Box-Muller变换转换成正态分布随机数
    local z0 = math.sqrt(-2.0 * math.log(u1)) * math.cos(2.0 * math.pi * u2)
    -- 使用均值和标准差进行线性变换
    return math.floor(mean + z0 * stddev + 0.5)
end

-- 生成指定范围内满足正态分布的随机数(95.00%概率不超过n，且不小于m)
function random(m, n)
    local mean = (m + n) / 2
    local sigma = (n - m) / (2 * 1.645) -- 1.645 0.9500 1.2815 0.9000
    local generated_random = generate_normal_random(mean, sigma)
    while (generated_random < m) do
        generated_random = math.random(m, n)
    end
    if (m == 10) then
        OutputLogMessage("%f\n", generated_random)
    end
    return generated_random
end

-- 公共函数 ---------------------------------------

-- 入口方法
function OnEvent(event, arg)
    -- OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")

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


    -- 满速炼狱
    -- 101，150（这是按压区间） 15，17（这是抬起时间） 就是满速
    if (event == "MOUSE_BUTTON_PRESSED" and arg == lianyu) then
        repeat
            PressMouseButton(1)
            Sleep(random(101, 150)) -- 按压区间
            ReleaseMouseButton(1)
            Sleep(random(15, 17)) -- 抬起区间
        until not IsMouseButtonPressed(lianyu)
    end

end
