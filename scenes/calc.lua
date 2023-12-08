local composer = require("composer"); -- вызов библиотеки Composer
local scene = composer.newScene() 
local widget = require("widget");

weightMin	= 40;   -- минимальный вес
weightMax 	= 140;  -- максимальный вес

weight = 60; -- вес пользователя

-- прячем строку состояния
display.setStatusBar(display.HiddenStatusBar);

-- фон приложения
display.setDefault("background", 37/255, 39/255, 46/255);
	
-- цвет текста по умолчанию
display.setDefault("fillColor", 0);

-- ширина контента
w = display.contentWidth - 20;


-- Вес
------------------------------------------------------------------

-- создаём группу для ввода веса
local weightGroup = display.newGroup(); 

-- добавляем круг
display.newCircle(weightGroup, display.contentCenterX, 74, 60):setFillColor(244/255);
	
-- прямоугольник со скруглёнными уголками
display.newRoundedRect(weightGroup, display.contentCenterX, 110, w, 100, 10):setFillColor(244/255);

-- выводим текст
display.newText(weightGroup, "Укажите вес в килограммах", display.contentCenterX, 90, native.systemFont, 24);

-- выводим текущий вес
local myWeight = display.newText({
	parent = weightGroup,
	text = weight,
	x = display.contentCenterX, y = 53,
	font = native.systemFont, 
	fontSize = 50,
});

-- меняем цвет текста
myWeight:setFillColor(0/255, 131/255, 202/255);

-- параметры слайдера
local optionsSlider = {
	frames = {   
		{ x=0, y=0, width=15, height=45 },
		{ x=16, y=0, width=130, height=45 },
		{ x=332, y=0, width=15, height=45 },
		{ x=153, y=0, width=15, height=45 },        
		{ x=353, y=0, width=47, height=47 },
	},
	sheetContentWidth = 400,
	sheetContentHeight = 45
}

-- выводим слайдер для ввода веса
weightSlider = widget.newSlider {
	sheet = graphics.newImageSheet("img/slider3.png", optionsSlider),
	leftFrame = 1, middleFrame = 2, rightFrame = 3, fillFrame = 4, handleFrame = 5,
	frameWidth = 15, frameHeight = 45,
	handleWidth = 45, handleHeight = 45,
	-- координаты слайдера
	top = 110, left= 91,
	-- размеры слайдера
	width = 360, height=47,
	orientation = "horizontal",
	-- устанавливаем положение ползунка веса
	value = 100*(weight - weightMin)/(weightMax - weightMin),
	-- выводим вес при перемещении слайдера
	listener = function(event)
		--weight = weightMin + event.value; -- простой вариант
		-- универсальный вариант
		weight = math.round(weightMin + (weightMax - weightMin)*event.value/100);
		myWeight.text = weight; -- выводим новый текст
	end
}

weightGroup:insert(weightSlider); -- добавляем слайдер в группу
-- кнопка минус
weightMinusButton = widget.newButton {
shape = 'roundedRect',
raidus = 5,
width = 60, height = 60,
left = 19, top = 90,
fontSize = 40,
fillColor = { default={ 150/255 }, over={ 76/255 } },
labelColor = { default={ 0 }, over={ 1 } },
label = "-",
onPress = function(event)
if (weight > weightMin) then
weight = weight - 1;
myWeight.text = weight;
weightSlider:setValue(100*(weight - weightMin)/(weightMax -
weightMin));
end
end
}
-- кнопка плюс
weightPlusButton = widget.newButton {
shape = 'roundedRect',
raidus = 5,
width = 60, height = 60,
left = 462, top = 90,
fontSize = 40,
fillColor = { default={ 150/255 }, over={ 76/255 } },
labelColor = { default={ 0 }, over={ 1 } },
label = "+",
onPress = function(event)
if (weight < weightMax) then
weight = weight + 1;
myWeight.text = weight;
weightSlider:setValue(100*(weight - weightMin)/(weightMax -
weightMin));
end
end
}

function scene:show(event)
local sceneGroup = self.view;

end
scene:addEventListener("show", scene);
return scene;