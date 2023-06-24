function color(hex)
  hex = hex:gsub("#", "")

  local r = tonumber(hex:sub(1, 2), 16) / 255
  local g = tonumber(hex:sub(3, 4), 16) / 255
  local b = tonumber(hex:sub(5, 6), 16) / 255

  return { r, g, b }
end

--{{{ Window
function window_set_size(width, height)
  lyte.set_window_minsize(width, height)
  lyte.set_window_size(width, height)
end

function window_set_title(title) lyte.set_window_title(title) end
function window_get_width() return lyte.get_window_width() end
function window_get_height() return lyte.get_window_height() end
--}}}

--{{{ Input
function keyboard_check(key) return lyte.is_key_down(key) end
function keyboard_check_pressed(key) return lyte.is_key_pressed(key) end
function keyboard_check_released(key) return lyte.is_key_released(key) end

function mouse_check_button(button) return lyte.is_mouse_down(button) end
function mouse_check_button_pressed(button) return lyte.is_mouse_pressed(button) end
function mouse_check_button_released(button) return lyte.is_mouse_released(button) end
--}}}

--{{{ Math
function irandom_range(min, max) return math.random(min, max) end
function irandom(max) return irandom_range(0, max) end

function random_range(min, max) return min + math.random() * (max - min) end
function random(max) return random_range(0, max) end

function max(a, b) return a > b and a or b end
function min(a, b) return a < b and a or b end
function floor(x) return math.floor(x) end
--}}}

--{{{ Instance and Layers
local layers = {}

function instance_layer_create(layer) layers[layer] = {} end
function instance_layer_get_all(layer) return layers[layer] end

function instance_create(object, layer_name)
  if layers[layer_name] then
    table.insert(layers[layer_name], object)
  end
end

function instance_layer_update(layer, delta)
  for _, o in ipairs(layers[layer]) do o:update(delta) end
end

function instance_layer_draw(layer)
  for _, o in ipairs(layers[layer]) do o:draw() end
end

function intersects(a, b)
  return a.x < b.x + b.width and b.x < a.x + a.width and a.y < b.y + b.height and b.y < a.y + a.height
end
--}}}

--{{{ Draw
local alpha = 1.0

function draw_clear()
  lyte.cls(0, 0, 0, 1)
  lyte.set_color(1, 1, 1, 1)
end

function draw_clear_color(color)
  lyte.cls(color[1], color[2], color[3], 1.0)
  lyte.set_color(1, 1, 1, 1)
end

function draw_set_color(color) lyte.set_color(color[1], color[2], color[3], alpha) end
function draw_set_alpha(a) alpha = a end

function draw_image(image, x, y) lyte.draw_image(image, floor(x), floor(y)) end
function draw_image_ext(image, x, y, rotation)
  lyte.push_matrix()

  lyte.translate(floor(x), floor(y))
  lyte.rotate_at(rotation, image.width/2, image.height/2)
  lyte.draw_image(image, 0, 0)

  lyte.pop_matrix()
end

function draw_surface(surface, x, y, scale)
  lyte.push_matrix()
  lyte.scale(scale, scale)
  lyte.draw_image(surface, floor(x), floor(y))
  lyte.pop_matrix()
end

function surface_create(width, height) return lyte.new_canvas(width, height) end
function surface_set_target(surface)
  if surface then lyte.set_canvas(surface)
  else lyte.reset_canvas() end
end

function draw_text(text, x, y) lyte.draw_text(text, floor(x), floor(y)) end
--}}}

--{{{ image loading functions
function load_image(path) return lyte.load_image("images/" .. path .. ".png") end

function image_get_width(image) return lyte.get_image_width(image) end
function image_get_height(image) return lyte.get_image_height(image) end
--}}}
