--FlappyStand or StandBird idk byCøcøW#6969 V0.1 

require("natives-1606100775")
local bird_file = "flappy.png" -- default file name
local tube_file = "tube.png" -- default file name
local bird_tex = directx.create_texture(filesystem.scripts_dir() .. bird_file) --  file
local tube_tex = directx.create_texture(filesystem.scripts_dir() .. tube_file) --  file
local logo_tex = directx.create_texture(filesystem.scripts_dir() .. "logo.png") --  file
local over_tex = directx.create_texture(filesystem.scripts_dir() .. "gameover.png") --  file

local bird_posX = 0.4 --default position X
local bird_posY = 0.5 --default position Y

local tube1_posX = 0.0 --default position X
local tube2_posX = 0.25 --default position X
local tube3_posX = 0.5 --default position X
local tube4_posX = 0.75 --default position X
local tube5_posX = 1.0 --default position X
local tube1_posY = 0.0 --default position Y
local tube2_posY = 0.0 --default position Y
local tube3_posY = 0.0 --default position Y
local tube4_posY = 0.0 --default position Y
local tube5_posY = 0.0 --default position Y

local sc = 0 --score (dont hack it bruh, anyway there is the new r* anti cheat)
local st = 1 --stage (dont hack it bruh, anyway there is the new r* anti cheat)
local score = 0 -- printed score

--Default rotation and speed
local rotation = 0.0
local tube_speed = 0.001
local bird_speed = 0.003

local dead = 2 --game over if = 1 / if = 2 start menu / if = 0 game 

local txt_colour = {	--default text colour
			["r"] = 1.0,
			["g"] = 0.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
		
local size = 0.05 --default size

GenerateFeatures = function()
 menu.divider(menu.my_root(), "Flappy options")
 menu.slider(menu.my_root(), "Change flappy style", {"flappystyle"}, "", 1, 3, 1, 1, function(style)
	if style == 1 then
	bird_file = "flappy.png"
	bird_tex = directx.create_texture(filesystem.scripts_dir() .. bird_file) 
	end
	if style == 2 then
	bird_file = "flappy_y.png"
	bird_tex = directx.create_texture(filesystem.scripts_dir() .. bird_file) 
	end
	if style == 3 then
	bird_file = "stand.png"
	bird_tex = directx.create_texture(filesystem.scripts_dir() .. bird_file) 
	end
end)
menu.action(menu.my_root(), "Change Flappy file name", {"flappyfile"}, "The new file file must be in Lua Scripts of stand (put .png / .jpeg in the name)", function(click_type)  --input text 
    menu.show_command_box_click_based(click_type, "flappyfile ")
end, function(arg)
    bird_file = arg
	bird_tex = directx.create_texture(filesystem.scripts_dir() .. bird_file) 
end, "flappyfile [text]")
menu.slider(menu.my_root(), "Flappy size", {"flappys"}, "", 1, 100, 5, 1, function(s)
	size=s/100
end)
menu.divider(menu.my_root(), "Tubes options")
 menu.slider(menu.my_root(), "Change tubes style", {"tubestyle"}, "", 1, 3, 1, 1, function(style)
	if style == 1 then
	tube_file = "tube.png"
	tube_tex = directx.create_texture(filesystem.scripts_dir() .. tube_file) 
	end
	if style == 2 then
	tube_file = "tube_g.png"
	tube_tex = directx.create_texture(filesystem.scripts_dir() .. tube_file) 
	end
	if style == 3 then
	tube_file = "tube_pain.png"
	tube_tex = directx.create_texture(filesystem.scripts_dir() .. tube_file) 
	end
end)
menu.action(menu.my_root(), "Change Tubes file name", {"tubesfile"}, "The new file file must be in Lua Scripts of stand (put .png / .jpeg in the name)", function(click_type)  --input text 
    menu.show_command_box_click_based(click_type, "tubesfile ")
end, function(arg)
    tube_file = arg
	tube_tex = directx.create_texture(filesystem.scripts_dir() .. tube_file) 
end, "tubesfile [text]")
menu.divider(menu.my_root(), "Ui options")
menu.colour(menu.my_root(), "Change text colours", {"txtc"}, "", txt_colour, true, function(colour)
	txt_colour = colour
end)
menu.divider(menu.my_root(), "Game options")
menu.slider(menu.my_root(), "Change speed", {"fspeed"}, "", 1, 10, 1, 1, function(int)
	tube_speed=int/1000
end)
end

GenerateFeatures()

while true do 
	
	if dead == 2 then 	-------------- MAIN MENU SCREEN
	directx.draw_texture(		----logo 
		logo_tex,	-- id
		0.15,			-- sizeX
		0.15,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		0.5,			-- posX
		0.25,			-- posY
		1.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_text(	-------------------  input menu text
		0.38,		-- x 
		0.6,		-- y 
		"Press ENTER to play !",			-- text
		ALIGN_TOP_LEFT,	-- alignment
		1.5,			-- scale
		txt_colour,		-- colour
		false				
	)
	directx.draw_text(	-------------------  help text
		0.4,		-- x 
		0.9,		-- y 
		"Tips : press SPACE to jump :D",			-- text
		ALIGN_TOP_LEFT,	-- alignment
		1.0,			-- scale
		txt_colour,		-- colour
		false				
	)	
	sc = 0 --anti cheat (dont touch it does break the lua!)		
	local start = PAD.IS_CONTROL_PRESSED(0,191)--enter key
	st = 1 --anti cheat (dont touch it does nothing!)	
	if start then --launch game
		dead = 0
	end
	end
	if dead == 0 then
	-------------------------------STAGES 
	if sc >= 50 then 
		tube_speed = 0.002
		st = 2
	end
	if sc >= 100 then 
		tube_speed = 0.003
		st = 3
	end
	if sc >= 200 then 
		tube_speed = 0.004
		st = 4
	end
	if sc >= 500 then 
		tube_speed = 0.004
		st = 5
	end
	if sc >= 1000 then 
		tube_speed = 0.005
		st = 6
	end
	if sc >= 100000 then 
		tube_speed = 0.01
		st = " CHEATER !"
	end
	------------------------------------------MOVE THE TUBES
	if tube1_posX >= -0.125 then
		tube1_posX = tube1_posX - tube_speed
	else
		tube1_posX = 1.125
		tube1_posY=math.random(-2,2)/10
		sc = sc + 1
	end
	if tube2_posX >= -0.125 then
		tube2_posX = tube2_posX - tube_speed
	else
		tube2_posX = 1.125
		tube2_posY=math.random(-2,2)/10
		sc = sc + 1
	end
	
	if tube3_posX >= -0.125 then
		tube3_posX = tube3_posX - tube_speed
	else
		tube3_posX = 1.125
		tube3_posY=math.random(-2,2)/10
		sc = sc + 1
	end
	if tube4_posX >= -0.125 then
		tube4_posX = tube4_posX - tube_speed
	else
		tube4_posX = 1.125
		tube4_posY=math.random(-2,2)/10
		sc = sc + 1
	end
	if tube5_posX >= -0.125 then
		tube5_posX = tube5_posX - tube_speed
	else
		tube5_posX = 1.125
		tube5_posY=math.random(-2,2)/10
		sc = sc + 1
	end
	--------------------COLLISIONS
	if bird_posY <= tube1_posY+0.4 then
		if tube1_posX >= 0.35 and tube1_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY >= tube1_posY+0.6 then
		if tube1_posX >= 0.35 and tube1_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY <= tube2_posY+0.4 then
		if tube2_posX >= 0.35 and tube2_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY >= tube2_posY+0.6 then
		if tube2_posX >= 0.35 and tube2_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY <= tube3_posY+0.4 then
		if tube3_posX >= 0.35 and tube3_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY >= tube3_posY+0.6 then
		if tube3_posX >= 0.35 and tube3_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY <= tube4_posY+0.4 then
		if tube4_posX >= 0.35 and tube4_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY >= tube4_posY+0.6 then
		if tube4_posX >= 0.35 and tube4_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY <= tube5_posY+0.4 then
		if tube5_posX >= 0.35 and tube5_posX <= 0.45 then
		dead = 1
		end
	end
	if bird_posY >= tube5_posY+0.6 then
		if tube5_posX >= 0.35 and tube5_posX <= 0.45 then
		dead = 1
		end
	end
	---------------------------------------------JUMP
	jump = PAD.IS_CONTROL_PRESSED(0,22) --jump key (on when space is pressed)
	
	if jump and dead == 0 then
		rotation = rotation + 0.05
		bird_posY = bird_posY - bird_speed
		if bird_posY <= 0.0 then
			bird_posY = 0.0
		end
	else
	bird_posY = bird_posY + bird_speed
		if bird_posY >= 1.0 then
			bird_posY = 1.0
		end
	end
	---------------------------------TEXTURES
		directx.draw_texture(		----Flappy
		bird_tex,	-- id
		size,			-- sizeX
		size,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		bird_posX,			-- posX
		bird_posY,			-- posY
		rotation,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		---- tube 1 bottom
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube1_posX,			-- posX
		tube1_posY+0.9,			-- posY
		0.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		----tube 1 top
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube1_posX,			-- posX
		tube1_posY+0.1,			-- posY
		0.5,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		---- tube 2 bottom
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube2_posX,			-- posX
		tube2_posY+0.9,			-- posY
		0.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		----tube 2 top
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube2_posX,			-- posX
		tube2_posY+0.1,			-- posY
		0.5,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	
	directx.draw_texture(		---- tube 3 bottom
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube3_posX,			-- posX
		tube3_posY+0.9,			-- posY
		0.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		----tube 3 top
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube3_posX,			-- posX
		tube3_posY+0.1,			-- posY
		0.5,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		---- tube 4 bottom
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube4_posX,			-- posX
		tube4_posY+0.9,			-- posY
		0.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		----tube 4 top
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube4_posX,			-- posX
		tube4_posY+0.1,			-- posY
		0.5,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		---- tube 5 bottom
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube5_posX,			-- posX
		tube5_posY+0.9,			-- posY
		0.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_texture(		----tube 5 top
		tube_tex,	-- id
		0.4,			-- sizeX
		0.4,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		tube5_posX,			-- posX
		tube5_posY+0.1,			-- posY
		0.5,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	--------------------------------------------UI TEXT
	directx.draw_text(	-------------------  score
		0.45,		-- x 
		0.2,		-- y 
		sc,			-- text
		ALIGN_TOP_LEFT,	-- alignment
		1.5,			-- scale
		txt_colour,		-- colour
		false				
	)	
	directx.draw_text(	-------------------  stage 
		0.8,		-- x 
		0.2,		-- y 
		"Stage : "..st,			-- text
		ALIGN_TOP_LEFT,	-- alignment
		1.2,			-- scale
		txt_colour,		-- colour
		false				
	)	
	end

	if dead == 1 then --------------------------GAME OVER SCREEN
	directx.draw_texture(		----logo game over
		over_tex,	-- id
		0.15,			-- sizeX
		0.15,			-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		0.5,			-- posX
		0.3,			-- posY
		1.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
	directx.draw_text(	-------------------  game over score text
		0.42,		-- x 
		0.4,		-- y 
		"Your score : "..score,			-- text
		ALIGN_TOP_LEFT,	-- alignment
		1.6,			-- scale
		txt_colour,		-- colour
		false				
	)	
	directx.draw_text(	-------------------  input game over text
		0.35,		-- x 
		0.6,		-- y 
		"Press ENTER to play again !",			-- text
		ALIGN_TOP_LEFT,	-- alignment
		1.5,			-- scale
		txt_colour,		-- colour
		false				
	)
	directx.draw_text(	-------------------  help text
		0.4,		-- x 
		0.9,		-- y 
		"Tips : press SPACE to jump :D",			-- text
		ALIGN_TOP_LEFT,	-- alignment
		1.0,			-- scale
		txt_colour,		-- colour
		false				
	)		
	score = sc --reset score
	local start = PAD.IS_CONTROL_PRESSED(0,191)--enter key
	if start then --launch game	(reset values)
		dead = 0 --game mode
		sc = 0 --default 
		rotation = 0.0 --default rotation
		bird_posX = 0.4 --default position X
		bird_posY = 0.5 --default position Y
		tube1_posX = 0.0 --default position X
		tube2_posX = 0.25 --default position X
		tube3_posX = 0.5 --default position X
		tube4_posX = 0.75 --default position X
		tube5_posX = 1.0 --default position X
		tube1_posY = 0.0 --default position Y
		tube2_posY = 0.0 --default position Y
		tube3_posY = 0.0 --default position Y
		tube4_posY = 0.0 --default position Y
		tube5_posY = 0.0 --default position Y
	end
	end
	
		util.yield() 
end

while true do  
	util.yield()
end


