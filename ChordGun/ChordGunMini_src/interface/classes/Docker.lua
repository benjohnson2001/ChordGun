-- @noindex
local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ChordGun/ChordGunMini_src"
require(workingDirectory .. "/util")
require(workingDirectory .. "/globalState")

Docker = {}
Docker.__index = Docker

function Docker:new()

  local self = {}
  setmetatable(self, Docker)

  return self
end

local function dockWindow()

  local dockState = getDockState()
  gfx.dock(dockState)
  setWindowShouldBeDocked(true)

  guiShouldBeUpdated = true
end

function Docker:drawDockWindowContextMenu()

  setPositionAtMouseCursor()
  local selectedIndex = gfx.showmenu("dock window")

  if selectedIndex <= 0 then
    return
  end

  dockWindow()
  gfx.mouse_cap = 0
end

local function undockWindow()

  setWindowShouldBeDocked(false)
  gfx.dock(0)
  guiShouldBeUpdated = true
end

function Docker:drawUndockWindowContextMenu()

  setPositionAtMouseCursor()
  local selectedIndex = gfx.showmenu("undock window")

  if selectedIndex <= 0 then
    return
  end

  undockWindow()
  gfx.mouse_cap = 0
end

function Docker:update()

  if rightMouseButtonIsHeldDown() and windowIsDocked() then
    self:drawUndockWindowContextMenu()
  end

  if rightMouseButtonIsHeldDown() and windowIsNotDocked() then
    self:drawDockWindowContextMenu()
  end
end