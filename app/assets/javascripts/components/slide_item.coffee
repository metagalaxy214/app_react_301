SlideItem = React.createClass
  getInitialState: ->
    {
      dialogIsOpen: false
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

  render: ->
    R.div
      className: "slide",
      R.div
        className: "wrap",
        HandleDialog({
          open: @state.dialogIsOpen
          onClose: @handleCloseDialog
        }, PairingBox())
        R.img
          alt: "Img.slide #{@props.slide_number}"
          src: @props.image
        R.div
          className: "description",
          R.div
            className: "heading",
            @props.heading
          R.div
            className: "Meals",
            @props.meals

window.SlideItem = SlideItem
