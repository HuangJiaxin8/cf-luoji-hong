------------------------单击鼠标滚轮控制整个宏开关--------------------------------
switch_key = 3
-------------------数字对应侧键-------------------------
purgatory_key = 4 -----------------炼狱速点指定侧键，只能4或5-------------
-----------如果设置为1，则可以直接使用鼠标左键（需要将开枪键改成L，数字设置成1，平时记得按总开关键 关闭后再点左键，不然会乱打字）---------
-- 总开关状态，默认为开启
switch = true
-- 启用鼠标左键监测事件
EnablePrimaryMouseButtonEvents(true)
-- 初始化随机种子（注意，罗技lua不支持os.time取随机数种子，但提供了GetDate函数）
math.randomseed(GetDate("%H%M%S"):reverse())  -- 由于lua底层使用C语言的LCG随机数算法，会导致相近种子产生的结果也相近，逆序即可避免此问题

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
    local sigma = (n - m) / (2 * 1.645)  -- 1.645 0.9500 1.2815 0.9000
    local generated_random = generate_normal_random(mean, sigma)
    while (generated_random < m) do
        generated_random = math.random(m, n)
    end
    if (m == 10) then
        OutputLogMessage("%f\n", generated_random)
    end
    return generated_random
end

-- 处理事件的函数
function OnEvent(event, arg)
    -- 按下任意鼠标键的事件触发
    if (event == "MOUSE_BUTTON_PRESSED") then
        -- 中键，开启关闭功能
        if (arg == switch_key) then
            switch = not switch
            if (switch) then
                OutputLogMessage("Macro is on!\n")
            else
                OutputLogMessage("Macro is off!\n")
            end
        -- 总开关switch为开启状态时执行以下操作
        elseif (switch) then
            -- 按下指定按键的事件触发
            if (arg == purgatory_key) then
                -- 随机延迟一定时间（10~25毫秒）
                Sleep(random(15, 17))
                -- 如果不是左键
                if (arg ~= 1) then
                    -- 重复执行以下操作直到侧键释放
                    repeat
                        -- 模拟按下鼠标左键
                        PressMouseButton(1)
                        -- 随机延迟一定时间（100~185毫秒）
                        Sleep(random(101, 150))
                        -- 松开鼠标左键
                        ReleaseMouseButton(1)
                        -- 随机延迟一定时间（10~25毫秒）
                        Sleep(random(15, 17))
                    until not IsMouseButtonPressed(purgatory_key)
                -- 指定为左键触发
                else
                    -- 重复执行以下操作直到左键释放
                    repeat
                        -- 模拟按下键盘上的L键
                        PressKey("L")
                        -- 随机延迟一定时间（100~185毫秒）
                        Sleep(random(100, 185))
                        -- 松开键盘上的L键
                        ReleaseKey("L")
                        -- 随机延迟一定时间（10~25毫秒）
                        Sleep(random(10, 25))
                    until not IsMouseButtonPressed(1)
                end
            end
        end
    end
end