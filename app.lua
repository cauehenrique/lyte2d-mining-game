require("engine")
require("object")

local Block = require("objects.block")
local Unit = require("objects.unit")

VIRTUAL_WIDTH = 320
VIRTUAL_HEIGHT = 180
GAME_SCALE = 3

local pixel_surface = surface_create(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

local start_y = 96

colors = {
	white = color("ffffff"),
	red_500 = color("ff0000")
}

instance_layer_create("blocks")
instance_layer_create("units")

local garbage_data_timer = 1.0

for i = 0, 47 do
	for j = 0, 12 do
		local block_texture_index = 0

		if j >= 1 then
			block_texture_index = 1

			if j >= 3 then
				block_texture_index = irandom_range(1, 2)
			end
		end

		instance_create(Block(i * 8, start_y + j * 8, block_texture_index), "blocks")
	end
end

local function __update(delta)
  if keyboard_check_pressed("f7") then
    GAME_SCALE = max(GAME_SCALE - 1, 1)
    window_set_size(GAME_SCALE * VIRTUAL_WIDTH, GAME_SCALE * VIRTUAL_HEIGHT)
  end

  if keyboard_check_pressed("f8") then
    GAME_SCALE = min(GAME_SCALE + 1, 6)
    window_set_size(GAME_SCALE * VIRTUAL_WIDTH, GAME_SCALE * VIRTUAL_HEIGHT)
  end

  if mouse_check_button_pressed("mb1") then
    instance_create(Unit(32, 32), "units")
  end

  instance_layer_update("blocks", delta)
  instance_layer_update("units", delta)

  garbage_data_timer = max(garbage_data_timer - delta, 0)
  if garbage_data_timer <= 0 then
    garbage_data_timer = 1.0

    local memory = collectgarbage("count") / 1000
    lyte.set_window_title("lyte-cool-game | " .. string.format("%.2f", memory) .. "mb")
  end
end

local function __draw()
	surface_set_target(pixel_surface)
	draw_clear_color(colors.white)

	instance_layer_draw("blocks")
  instance_layer_draw("units")

	surface_set_target()

	draw_clear()
	draw_surface(pixel_surface, 0, 0, GAME_SCALE)
end

function lyte.tick(delta)
  __update(delta)
  __draw()
end
