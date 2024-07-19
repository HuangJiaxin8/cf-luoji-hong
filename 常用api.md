
```lua

--罗技G502键位图：
https://github.com/kiccer/Soldier76/blob/master/%E9%94%AE%E4%BD%8D%E5%9B%BE/g502%E6%8C%89%E9%94%AE%E7%BC%96%E5%8F%B7%E5%9B%BE.png


-- 参考说明书 
-- 左键 = 1
-- 右键 = 2
-- 滚轮单击 = 3
-- 左上 = 5
-- 左下 = 4
-- 左上上=6
-- 左前（调dpi）= 8
-- 左后（调dpi）= 7
-- 滚轮的下下 = 9 


-- 炼狱宏参数
101，150（这是按压区间）
15，17（这是抬起时间）
就是满速。


-- 按空格键：
PressKey("spacebar")


-- 启用鼠标左键监测事件
EnablePrimaryMouseButtonEvents(true)

-- 模拟按下鼠标左键
PressMouseButton(1)

-- 睡眠
Sleep()






-- 初始化随机种子（注意，罗技lua不支持os.time取随机数种子，但提供了GetDate函数）
math.randomseed(GetDate("%H%M%S"):reverse()) 


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




while(IsMouseButtonPressed(鼠标键值))
      do
        PressKey("spacebar")
        Sleep(math.random(8,11))                 
        ReleaseKey("spacebar")
        Sleep(math.random(8,11))
      end  



-- 入口方法
function OnEvent(event, arg)


-- 日志打印                         
OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")
OutputLogMessage("Hello World %d\n",2007)

``` 