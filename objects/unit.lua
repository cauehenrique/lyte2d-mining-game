local Unit = Object:extend()

local _texture = load_image("unit")

function Unit:new(x, y)
  self.x = x
  self.y = y
  self.width = _texture.width
  self.height = _texture.height

  self.hspeed = 10
  self.vspeed = 30
  self.image_angle = 0

  self.level = 0
  self.texture = _texture
end

function Unit:update(delta)
  local blocks = instance_layer_get_all("blocks")

  self.x = self.x + self.hspeed * delta
  for _, block in ipairs(blocks) do
    if intersects(self, block) then
      if self.hspeed > 0 then self.x = block.x - self.width end
      if self.hspeed < 0 then self.x = block.x + block.texture.width end
    end
  end

  self.y = self.y + self.vspeed * delta
  for _, block in ipairs(blocks) do
    if intersects(self, block) then
      if self.vspeed > 0 then self.y = block.y - self.height end
      if self.vspeed < 0 then self.y = block.y + block.texture.height end
    end
  end
end

function Unit:draw()
  draw_image_ext(self.texture, self.x, self.y, self.image_angle)
end

return Unit
