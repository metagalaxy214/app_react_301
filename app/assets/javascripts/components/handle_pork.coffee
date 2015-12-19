HandlePork = React.createClass
  getDefaultProps: ->
    open: false
    modal: true
    title: ''
    onOpen: ()->
    onClose: ()->
  handlePropsChanged: (props) ->
    props = props || @props
    React.renderComponent(React.Children.only(@props.children), @node)
    console.log(@dialog)
    if (props.open)
      @dialog.dialog("open")
    else
      @dialog.dialog("close")

  componentWillReceiveProps: (newProps) ->
    @handlePropsChanged(newProps)

  componentDidMount: ->
    @node = @getDOMNode()
    console.log("inside componentDidMount")
    options =
      width: '80%'
      modal: true
      closeText: 'X'
      close: @props.onClose
      show: "fade"
      open: @props.onOpen
      title: @props.title
      autoOpen: false
    @dialog = $(@node).dialog(options)
    console.log("inside componentDidMount")
    @handlePropsChanged()
  componentWillUnmount: ->
    @dialog.destroy()
  render: ->
    R.div null
window.HandlePork = HandlePork
