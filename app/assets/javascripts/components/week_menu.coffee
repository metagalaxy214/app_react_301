WeekMenu = React.createClass
  getInitialState: ->
    {
      dialogIsOpen: false
      porkDialogIsOpen: false
      beefDialogIsOpen: false
    }
  openDialog: -> 
    new_state = @state
    new_state.dialogIsOpen = true
    @setState(new_state)

  closeDialog: ->
    new_state = @state
    new_state.dialogIsOpen = false
    @setState(new_state)

  handleCloseDialog: ->
    new_state = @state
    new_state.dialogIsOpen = false
    @setState(new_state)

  openBeefDialog: -> 
    new_state = @state
    new_state.beefDialogIsOpen = true
    @setState(new_state)

  closeBeefDialog: ->
    new_state = @state
    new_state.beefDialogIsOpen = false
    @setState(new_state)

  handleCloseBeefDialog: ->
    new_state = @state
    new_state.beefDialogIsOpen = false
    @setState(new_state)

  openPorkDialog: -> 
    new_state = @state
    new_state.porkDialogIsOpen = true
    @setState(new_state)

  closePorkDialog: ->
    new_state = @state
    new_state.porkDialogIsOpen = false
    @setState(new_state)

  handleClosePorkDialog: ->
    new_state = @state
    new_state.porkDialogIsOpen = false
    @setState(new_state)




  render: ->
    R.section
      id: "week-menu",
      R.div
        className: "container",
        R.div
          className: "title"
          R.img
            src: "/assets/TR_thisweeksmenu.png"
        R.div
          className: "content",
          R.div
            className: "first-menu"
            R.img
              alt: "Work 1"
              src: "/assets/chicken-all.png"
              onClick: @openDialog
            HandleDialog({
              open: @state.dialogIsOpen
              onClose: @handleCloseDialog
            }, PairingBox({
              close: @handleCloseDialog
            }))
          R.div
            className: "second-menu"
            R.img
              alt: "Work 2"
              src: "/assets/pork-all.png"
              onClick: @openPorkDialog
            HandleDialog({
              open: @state.porkDialogIsOpen
              onClose: @handleClosePorkDialog
            }, PorkPairing({
              close: @closePorkDialog
            }))

          R.div
            className: "third-menu"
            R.img
              alt: "Work 3"
              src: "/assets/beef-all.png"
              onClick: @openBeefDialog
            HandleDialog({
              open: @state.beefDialogIsOpen
              onClose: @handleCloseBeefDialog
            }, BeefPairing({
              close: @closeBeefDialog
            }))




window.WeekMenu = WeekMenu
