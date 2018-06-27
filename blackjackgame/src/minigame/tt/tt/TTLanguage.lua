--牛牛语言
local TTLanguage = class("TTLanguage")
--1是中文简体   2个英文  3是中文繁体

function TTLanguage:split(str, reps)
    local resultStrsList = {};
    string.gsub(str, '[^' .. reps ..']+', function(w) table.insert(resultStrsList, w) end );
    return resultStrsList;
end
function TTLanguage:loadLanguageCsvFile(filePath) 
    -- 读取文件
    local data = cc.FileUtils:getInstance():getStringFromFile(filePath);
    -- 按行划分
    local lineStr = self:split(data, '\n\r');
    --[[
                从第3行开始保存（第一行是标题，第二行是注释，后面的行才是内容） 
            
                用二维数组保存：arr[ID][属性字符串]
    ]]
    local titles = self:split(lineStr[1], ",");
    local arrs = {};
    for i = 3, #lineStr, 1 do
        -- 一行中，每一列的内容
        local content = self:split(lineStr[i], ",");

        -- 以ID作为索引，保存每一列的内容，取值的时候这样取：arrs[1][1]
        local ID = tonumber(content[1])
        arrs[ID] = {};
        for j = 2, #titles, 1 do
            arrs[ID][(j-1)] = content[j];
        end
    end
    --dump(arrs)
    self.a = arrs
    return arrs;
end

return TTLanguage
