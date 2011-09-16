display.setStatusBar( display.HiddenStatusBar )

local pics = {}
local n = 0
local screen_width = 320
local screen_height = 480

local isselected = ""

local function onTouch( event )
	local t = event.target
	isselected = t.vid
	local phase = event.phase
	if "began" == phase then
		local parent = t.parent
		parent:insert( t )
		display.getCurrentStage():setFocus( t )
		t.isFocus = true
		t.x0 = event.x - t.x
		t.y0 = event.y - t.y
	elseif t.isFocus then
		if "moved" == phase then
			t.x = event.x - t.x0
			t.y = event.y - t.y0
		elseif "ended" == phase or "cancelled" == phase then
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
		end
	end
	return true
end


local function loadpic (img,vid)
	n = #pics + 1

	pics[n] = display.newImage(img)
	pics[n].x = math.random(screen_width)
	pics[n].y = math.random(screen_height)
	pics[n].id = img
	pics[n].vid = vid
	pics[n]:addEventListener( "touch", onTouch )

end

local function playvid ( event )
	media.playVideo( isselected, true, onComplete )
end

local onComplete = function(event)
   print( "video session ended" )
end


loadpic("2052.jpg")
loadpic("C243.jpg")
loadpic("G214.jpg")
loadpic("G238.jpg","rsm17.mp4")
loadpic("G321.jpg")
loadpic("J381.jpg")
loadpic("L255.jpg")
loadpic("P242.jpg")

local playbutton = display.newImage("playvideo.png")
playbutton.x = (screen_width / 2)
playbutton.y = 13
playbutton:addEventListener( "touch", playvid )

