local Block = Object:extend()

local block_images = {
  load_image("block_0"),
  load_image("block_1"),
  load_image("block_2")
}

function Block:new(x, y, texture_id)
  self.x = x
  self.y = y
  self.texture = block_images[texture_id + 1]
  self.width = self.texture.width
  self.height = self.texture.height
end

function Block:draw()
  draw_image(self.texture, self.x, self.y)
end

return Block
