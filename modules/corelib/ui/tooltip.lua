-- @docclass
g_tooltip = {}

-- private variables
local fadeInTime = 100
local fadeOutTime = 100
local toolTipLabel
local currentHoveredWidget
local toolTipAddonLabels = {}
local toolTipAddonGroupLabels = {} -- Rows background
local toolTipAddonsBackgroundLabel
local alignToAnchor = {
  [AlignLeft]   = AnchorLeft,
  [AlignRight]  = AnchorRight,
  [AlignCenter] = AnchorHorizontalCenter
}

-- private functions
local function removeToolTipAddonLabels()
  for i = 1, #toolTipAddonLabels do
    for j = 1, #toolTipAddonLabels[i] do
      toolTipAddonLabels[i][j]:destroy()
    end
    toolTipAddonGroupLabels[i]:destroy()
  end
  toolTipAddonLabels = {}
  toolTipAddonGroupLabels = {}
end

local function removeTooltip()
  g_effects.cancelFade(toolTipAddonsBackgroundLabel)
  toolTipAddonsBackgroundLabel:hide()
  for i = 1, #toolTipAddonLabels do
    for j = 1, #toolTipAddonLabels[i] do
      g_effects.cancelFade(toolTipAddonLabels[i][j])
    end
    g_effects.cancelFade(toolTipAddonGroupLabels[i])
  end
  removeToolTipAddonLabels()
end

local function moveToolTip(firstDisplay)
  local widget = g_game.getWidgetByPos()
  if not firstDisplay then
    if not toolTipLabel:isVisible() or toolTipLabel:getOpacity() < 0.1 then
      return
    end

    if not widget then -- No widget found (e.g., client background area)
      removeTooltip()
      currentHoveredWidget = nil
      return
    end
  end

  local pos    = g_window.getMousePosition()
  local width  = toolTipLabel:getWidth()
  local height = toolTipLabel:getHeight()
  if widget.tooltipAddons then
    width  = toolTipAddonsBackgroundLabel:getWidth()
    height = toolTipAddonsBackgroundLabel:getHeight()
  end

  local ydif = g_window.getSize().height - (pos.y + height)
  pos.y = ydif <= 10 and pos.y - height - (widget.tooltipAddons and -6 or 0) or pos.y + (widget.tooltipAddons and 6 or 0)

  local xdif = g_window.getSize().width - (pos.x + width)
  pos.x = xdif <= 10 and pos.x - width - (widget.tooltipAddons and 6 or 10) or pos.x + (widget.tooltipAddons and 15 or 11)

  toolTipLabel:setPosition(pos)
end

local function onWidgetHoverChange(widget, hovered)
  if widget.onTooltipHoverChange then
    if not widget.onTooltipHoverChange(widget, hovered) then
      return
    end
  end

  g_tooltip.widgetHoverChange(widget, hovered)
end

local function onWidgetStyleApply(widget, styleName, styleNode)
  if styleNode.tooltip then
    widget.tooltip = styleNode.tooltip
  end
end

-- public functions
function g_tooltip.init()
  connect(UIWidget, {
    onStyleApply = onWidgetStyleApply,
    onHoverChange = onWidgetHoverChange
  })

  addEvent(function()
    toolTipAddonsBackgroundLabel = g_ui.createWidget('UILabel', rootWidget)
    toolTipAddonsBackgroundLabel:setId('toolTipAddonsBackground')

    toolTipLabel = g_ui.createWidget('UILabel', rootWidget)
    toolTipLabel:setId('toolTip')
    toolTipLabel:setTextAlign(AlignCenter)
    toolTipLabel:hide()
    toolTipLabel.onMouseMove = function() moveToolTip() end
  end)
end

function g_tooltip.terminate()
  disconnect(UIWidget, {
    onStyleApply = onWidgetStyleApply,
    onHoverChange = onWidgetHoverChange
  })

  removeTooltip()

  currentHoveredWidget = nil

  toolTipLabel:destroy()
  toolTipLabel = nil

  toolTipAddonsBackgroundLabel:destroy()
  toolTipAddonsBackgroundLabel = nil

  g_tooltip = nil
end

function g_tooltip.display(widget)
  if not widget.tooltip and not widget.tooltipAddons or not toolTipLabel then return end

  toolTipLabel:setBackgroundColor('#111111cc')
  toolTipLabel:setText(widget.tooltip or '')
  toolTipLabel:resizeToText()
  if not widget.tooltipAddons then
    toolTipLabel:resize(toolTipLabel:getWidth() + 8, toolTipLabel:getHeight() + 8)
  end
  if not widget.tooltip or widget.tooltip:len() == 0 then
    toolTipLabel:setHeight(0) -- For fix the heightTotalSum
  end
  toolTipLabel:show()
  toolTipLabel:raise()
  toolTipLabel:enable()
  g_effects.fadeIn(toolTipLabel, fadeInTime)

  if widget.tooltipAddons then
    -- Force previous tooltip remove
    g_effects.cancelFade(toolTipAddonsBackgroundLabel)
    for i = 1, #toolTipAddonLabels do
      for j = 1, #toolTipAddonLabels[i] do
        g_effects.cancelFade(toolTipAddonLabels[i][j])
      end
      g_effects.cancelFade(toolTipAddonGroupLabels[i])
    end
    removeToolTipAddonLabels()

    local higherWidth    = 0
    local heightTotalSum = 0

    -- Group
    --[[
      Options:
      - backgroundColor
    ]]
    for i = 1, #widget.tooltipAddons do
      toolTipAddonGroupLabels[i] = g_ui.createWidget('Label', toolTipAddonsBackgroundLabel)
      toolTipAddonGroupLabels[i]:setId(string.format('toolTipAddonGroupLabels_%d', i))
      toolTipAddonGroupLabels[i]:addAnchor(AnchorTop, i < 2 and 'parent' or string.format('toolTipAddonGroupLabels_%d', i - 1), i < 2 and AnchorTop or AnchorBottom)
      if i == 1 then
        toolTipAddonGroupLabels[i]:setMarginTop(4)
      end
      toolTipAddonGroupLabels[i]:addAnchor(AnchorLeft, 'parent', AnchorLeft)
      toolTipAddonGroupLabels[i]:setMarginLeft(4)
      toolTipAddonGroupLabels[i]:addAnchor(AnchorRight, 'parent', AnchorRight)
      toolTipAddonGroupLabels[i]:setMarginRight(4)
      if i == #widget.tooltipAddons then
        toolTipAddonGroupLabels[i]:addAnchor(AnchorBottom, 'parent', AnchorBottom)
        toolTipAddonGroupLabels[i]:setMarginBottom(4)
      end
      if widget.tooltipAddons[i].backgroundColor then
        toolTipAddonGroupLabels[i]:setBackgroundColor(widget.tooltipAddons[i].backgroundColor)
      end
      if widget.tooltipAddons[i].backgroundIcon then
        toolTipAddonGroupLabels[i]:setIcon(widget.tooltipAddons[i].backgroundIcon)
        if widget.tooltipAddons[i].backgroundIconSize then
          toolTipAddonGroupLabels[i]:setSize(widget.tooltipAddons[i].backgroundIconSize)
          toolTipAddonGroupLabels[i]:setIconSize(widget.tooltipAddons[i].backgroundIconSize)
        end
      end
      if widget.tooltipAddons[i].onGroupBackground then
        widget.tooltipAddons[i].onGroupBackground(toolTipAddonGroupLabels[i], i)
      end

      -- Addons
      --[[
        Options:
        - backgroundColor
        - text
        - color
        - align (for text and icon)
        - icon
        - size (for icon)
        - onAddon(group, addon, i, j)
      ]]
      local addonsWidthSum = 0
      local higherHeight   = 0
      toolTipAddonLabels[i] = {}
      for j = 1, #widget.tooltipAddons[i] do
        toolTipAddonLabels[i][j] = g_ui.createWidget('Label', toolTipAddonGroupLabels[i])
        local addon = toolTipAddonLabels[i][j]
        addon:setId(string.format('toolTipAddon_%d_%d', i, j))
        addon:addAnchor(AnchorTop, 'parent', AnchorTop)
        addon:addAnchor(AnchorBottom, 'parent', AnchorBottom)

        addon:addAnchor(AnchorLeft, j < 2 and 'parent' or string.format('toolTipAddon_%d_%d', i, j - 1), j < 2 and AnchorLeft or AnchorRight)
        if j == #widget.tooltipAddons[i] then addon:addAnchor(AnchorRight, 'parent', AnchorRight) end

        if widget.tooltipAddons[i][j].backgroundColor then
          addon:setBackgroundColor(widget.tooltipAddons[i][j].backgroundColor)
        end
        if widget.tooltipAddons[i][j].text then
          addon:setText(widget.tooltipAddons[i][j].text)
          addon:setColor(widget.tooltipAddons[i][j].color or 'white')
          addon:resizeToText()
          addon:setTextAlign(widget.tooltipAddons[i][j].align or AlignCenter)
        elseif widget.tooltipAddons[i][j].icon then
          addon:setIcon(widget.tooltipAddons[i][j].icon)
          if widget.tooltipAddons[i][j].size then
            addon:setSize(widget.tooltipAddons[i][j].size)
            addon:setIconSize(widget.tooltipAddons[i][j].size)
          end

          -- Icon align only if has the icon only on group
          if #widget.tooltipAddons[i] == 1 then
            addon:removeAnchor(AnchorLeft)
            addon:removeAnchor(AnchorRight)
            local align = alignToAnchor[widget.tooltipAddons[i][j].align or AlignCenter]
            addon:addAnchor(align, 'parent', align)
          end
        end

        addon:show()
        addon:raise()
        addon:enable()
        g_effects.fadeIn(addon, fadeInTime)

        addonsWidthSum = addonsWidthSum + addon:getWidth()
        local height   = (widget.tooltipAddons[i][j].icon and addon:getIconHeight() or addon:getHeight())
        higherHeight   = higherHeight > height and higherHeight or height
      end

      toolTipAddonGroupLabels[i]:setWidth(addonsWidthSum)
      toolTipAddonGroupLabels[i]:setHeight(higherHeight)
      toolTipAddonGroupLabels[i]:show()
      toolTipAddonGroupLabels[i]:enable()

      higherWidth    = higherWidth > addonsWidthSum and higherWidth or addonsWidthSum
      heightTotalSum = heightTotalSum + higherHeight
    end

    toolTipLabel:setWidth(higherWidth)

    -- Background
    --[[
      Options:
      - backgroundColor
      - onAddonsBackground
    ]]
    toolTipAddonsBackgroundLabel:setBackgroundColor(widget.toolTipAddonsBackground and widget.toolTipAddonsBackground.backgroundColor or '#111111cc')
    toolTipAddonsBackgroundLabel:setWidth(higherWidth + 8)
    toolTipAddonsBackgroundLabel:setHeight(heightTotalSum + 8)
    toolTipAddonsBackgroundLabel:show()
    toolTipAddonsBackgroundLabel:enable()
    toolTipAddonsBackgroundLabel:addAnchor(AnchorTop, 'toolTip', AnchorTop)
    toolTipAddonsBackgroundLabel:addAnchor(AnchorHorizontalCenter, 'toolTip', AnchorHorizontalCenter)
    if widget.toolTipAddonsBackground and widget.toolTipAddonsBackground.onAddonsBackground then
      widget.toolTipAddonsBackground.onAddonsBackground(toolTipAddonsBackgroundLabel)
    end
    g_effects.fadeIn(toolTipAddonsBackgroundLabel, fadeInTime)

    for i = 1, #widget.tooltipAddons do
      for j = 1, #widget.tooltipAddons[i] do
        if widget.tooltipAddons[i][j].onAddon then
          widget.tooltipAddons[i][j].onAddon(toolTipAddonGroupLabels[i], toolTipAddonLabels[i][j], i, j)
        end
      end
    end
  end

  moveToolTip(true)
end

function g_tooltip.hide(widget)
  if widget.tooltip then
    g_effects.fadeOut(toolTipLabel, fadeOutTime)
  end

  if widget.tooltipAddons then
    g_effects.fadeOut(toolTipAddonsBackgroundLabel, fadeOutTime)
    for i = 1, #toolTipAddonLabels do
      for j = 1, #toolTipAddonLabels[i] do
        g_effects.fadeOut(toolTipAddonLabels[i][j], fadeOutTime)
      end
      g_effects.fadeOut(toolTipAddonGroupLabels[i], fadeOutTime)
    end
  end
end

function g_tooltip.widgetHoverChange(widget, hovered)
  if hovered then
    if widget:hasTooltip() and not g_mouse.isPressed() then
      g_tooltip.display(widget)
      currentHoveredWidget = widget
    end
  else
    if widget == currentHoveredWidget then
      g_tooltip.hide(widget)
      currentHoveredWidget = nil
    end
  end
end

function g_tooltip.widgetUpdateHover(widget, hovered)
  g_tooltip.hide(widget)
  addEvent(function()
    g_tooltip.widgetHoverChange(widget, hovered)
  end)
end

-- @docclass UIWidget @{

--[[
  Usage

  Simple:
    Lua:
      widget:setTooltip('Title message.')
    Otui:
      UIWidget
        !tooltip: 'Title message.'

  Custom:
    Lua:
      widget:setTooltip({ {{ text = 'First message.\nSecond message.' }, backgroundColor = '#ffff0077', backgroundIcon = '/images/topbuttons/questlog', onGroupBackground = function(group, i) print_r(group:getSize(), i) end}, {{ icon = '/images/topbuttons/battle', size = { width = 20, height = 20 }, align = AlignCenter, onAddon = function(group, addon, i, j) print_r(group:getSize(), addon:getSize(), i, j) end }, { text = 'Duplicated!', color = 'green' }, backgroundColor = '#ff000077'}, {{ text = 'Left', backgroundColor = '#00ff0077', color = 'red', align = AlignLeft }}, {{ text = 'Right', align = AlignRight }} }, { backgroundColor = '#00007777', onAddonsBackground = function (widget) print_r(widget:getSize()) end })
    Otui:
      UIWidget
        &tooltipAddons: { {{ text = 'First message.\nSecond message.' }, backgroundColor = '#ffff0077', backgroundIcon = '/images/topbuttons/questlog', onGroupBackground = function(group, i) print_r(group:getSize(), i) end}, {{ icon = '/images/topbuttons/battle', size = { width = 20, height = 20 }, align = AlignCenter, onAddon = function(group, addon, i, j) print_r(group:getSize(), addon:getSize(), i, j) end }, { text = 'Duplicated!', color = 'green' }, backgroundColor = '#ff000077'}, {{ text = 'Left', backgroundColor = '#00ff0077', color = 'red', align = AlignLeft }}, {{ text = 'Right', align = AlignRight }} }
        &toolTipAddonsBackground: { backgroundColor = '#00007777', onAddonsBackground = function (widget) print_r(widget:getSize()) end }
]]

-- UIWidget extensions
function UIWidget:removeTooltip()
  self.tooltip = nil
  self.tooltipAddons = nil
  self.toolTipAddonsBackground = nil
end

function UIWidget:setTooltip(tooltip, toolTipAddonsBackground)
  self:removeTooltip()
  if type(tooltip) == "string" then
    self.tooltip = tooltip
  elseif type(tooltip) == "table" then
    self.tooltipAddons = tooltip
    self.toolTipAddonsBackground = toolTipAddonsBackground
  end
end

function UIWidget:getTooltip()
  return self.tooltip
end

function UIWidget:getTooltipAddons()
  return self.tooltipAddons
end

function UIWidget:getTooltipAddonsBackground()
  return self.toolTipAddonsBackground
end

function UIWidget:hasTooltip()
  return (self.tooltip or self.tooltipAddons) and true or false
end

-- @}

g_tooltip.init()
connect(g_app, { onTerminate = g_tooltip.terminate })
