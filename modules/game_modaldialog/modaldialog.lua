_G.GameModalDialog = { }
GameModalDialog.m  = modules.game_modaldialog -- Alias



modalDialog = nil

function GameModalDialog.init()
  g_ui.importStyle('modaldialog')

  connect(g_game, {
    onModalDialog = GameModalDialog.onModalDialog,
    onGameEnd     = GameModalDialog.destroyDialog
  })

  local dialog = rootWidget:recursiveGetChildById('modalDialog')
  if dialog then
    modalDialog = dialog
  end
end

function GameModalDialog.terminate()
  disconnect(g_game, {
    onModalDialog = GameModalDialog.onModalDialog,
    onGameEnd     = GameModalDialog.destroyDialog
  })

  _G.GameModalDialog = nil
end

function GameModalDialog.destroyDialog()
  if modalDialog then
    modalDialog:destroy()
    modalDialog = nil
  end
end

function GameModalDialog.onModalDialog(id, title, message, spectatorId, buttons, enterButton, escapeButton, choices, priority) -- priority parameter is unused, not sure what its use is.
  if modalDialog then
    return
  end

  modalDialog = g_ui.createWidget('ModalDialog', rootWidget)

  local messageLabel = modalDialog:getChildById('messageLabel')
  local choiceList = modalDialog:getChildById('choiceList')
  local choiceScrollbar = modalDialog:getChildById('choiceScrollBar')
  local buttonsPanel = modalDialog:getChildById('buttonsPanel')

  modalDialog:setText(title)
  messageLabel:setText(message)

  local labelHeight
  for i = 1, #choices do
    local choiceId = choices[i][1]
    local choiceName = choices[i][2]

    local label = g_ui.createWidget('ChoiceListLabel', choiceList)
    label.choiceId  = choiceId
    label.choiceKey = i
    label:setText(choiceName)
    label:setPhantom(false)
    if not labelHeight then
      labelHeight = label:getHeight()
    end
  end
  choiceList:focusChild(choiceList:getFirstChild())

  g_keyboard.bindKeyPress('Up', function() choiceList:focusPreviousChild(KeyboardFocusReason) end, modalDialog)
  g_keyboard.bindKeyPress('Down', function() choiceList:focusNextChild(KeyboardFocusReason) end, modalDialog)

  local buttonsWidth = 0
  for i = 1, #buttons do
    local buttonId = buttons[i][1]
    local buttonText = buttons[i][2]

    local button = g_ui.createWidget('ModalButton', buttonsPanel)
    button:setText(buttonText)
    button.onClick =
    function(self)
      local focusedChoice = choiceList:getFocusedChild()
      local choice    = 0xFF
      local choiceKey = 0
      if focusedChoice then
        choice    = focusedChoice.choiceId
        choiceKey = focusedChoice.choiceKey
      end
      g_game.answerModalDialog(id, buttonId, buttons[i] and buttons[i][2] or '', choice, choices[choiceKey] and choices[choiceKey][2] or '', spectatorId)
      GameModalDialog.destroyDialog()
    end

    buttonsWidth = buttonsWidth + button:getWidth() + button:getMarginLeft() + button:getMarginRight()
  end

  local additionalHeight = 0
  if #choices > 0 then
    choiceList:setVisible(true)
    choiceScrollbar:setVisible(true)

    additionalHeight = math.min(modalDialog.maximumChoices, math.max(modalDialog.minimumChoices, #choices)) * labelHeight
    additionalHeight = additionalHeight + choiceList:getPaddingTop() + choiceList:getPaddingBottom()
  end

  local horizontalPadding = modalDialog:getPaddingLeft() + modalDialog:getPaddingRight()
  buttonsWidth = buttonsWidth + horizontalPadding

  modalDialog:setWidth(math.min(modalDialog.maximumWidth, math.max(buttonsWidth, messageLabel:getWidth(), modalDialog.minimumWidth)))
  messageLabel:setWidth(math.min(modalDialog.maximumWidth, math.max(buttonsWidth, messageLabel:getWidth(), modalDialog.minimumWidth)) - horizontalPadding)
  modalDialog:setHeight(modalDialog:getHeight() + additionalHeight + messageLabel:getHeight() - 8)

  local enterFunc = function()
    local focusedChoice = choiceList:getFocusedChild()
    local choice    = 0xFF
    local choiceKey = 0
    if focusedChoice then
      choice    = focusedChoice.choiceId
      choiceKey = focusedChoice.choiceKey
    end
    local buttonTxT = ''
    for i = 1, #buttons do
      if i == enterButton then
        buttonTxT = buttons[i][2]
        break
      end
    end
    g_game.answerModalDialog(id, enterButton, buttonTxT, choice, choices[choiceKey] and choices[choiceKey][2] or '', spectatorId)
    GameModalDialog.destroyDialog()
  end

  local escapeFunc = function()
    local focusedChoice = choiceList:getFocusedChild()
    local choice    = 0xFF
    local choiceKey = 0
    if focusedChoice then
      choice    = focusedChoice.choiceId
      choiceKey = focusedChoice.choiceKey
    end
    local buttonTxT = ''
    for i = 1, #buttons do
      if i == escapeButton then
        buttonTxT = buttons[i][2]
        break
      end
    end
    g_game.answerModalDialog(id, escapeButton, buttonTxT, choice, choices[choiceKey] and choices[choiceKey][2] or '', spectatorId)
    GameModalDialog.destroyDialog()
  end

  choiceList.onDoubleClick = enterFunc

  modalDialog.onEnter = enterFunc
  modalDialog.onEscape = escapeFunc
end
