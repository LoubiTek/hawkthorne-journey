local app = require 'app'
local prompt = require 'prompt'

local save = require 'save'

local Savepoint = {}

Savepoint.__index = Savepoint
-- Nodes with 'isInteractive' are nodes which the player can interact with, but not pick up in any way
Savepoint.isInteractive = true

local image = love.graphics.newImage('images/bust.png')
image:setFilter('nearest', 'nearest')

function Savepoint.new(node, collider, level)
  local savepoint = {}
  setmetatable(savepoint, Savepoint)

  assert(node.name, "All savepoints must have names")

  savepoint.x = node.x
  savepoint.y = node.y
  savepoint.width = node.width
  savepoint.height = node.height
  savepoint.name = node.name
  savepoint.level = level

  savepoint.player_touched = false
  savepoint.bb = collider:addRectangle(node.x, node.y, node.width, node.height)
  savepoint.bb.node = savepoint
  collider:setPassive(savepoint.bb)

  return savepoint
end

function Savepoint:update(dt, player)
end

function Savepoint:keypressed( button, player)
end

function Savepoint:show()
end

function Savepoint:collide_end(node)
  if node.isPlayer then
    save:saveGame(self.level, self.name)
  end
end

function Savepoint:draw()
  love.graphics.draw(image, self.x, self.y)
end

return Savepoint


