HandleDialog = React.createClass
  getDefaultProps: ->
    open: false
    modal: true
    title: ''
    onOpen: ()->
    onClose: ()->
  handlePropsChanged: (props) ->
    props = props || @props
    React.renderComponent(React.Children.only(@props.children), @node)
    if (props.open)
      @dialog.dialog("open")
    else
      @dialog.dialog("close")

  componentWillReceiveProps: (newProps) ->
    @handlePropsChanged(newProps)

  componentDidMount: ->
    @node = @getDOMNode()
    options =
      width: '80%'
      modal: true
      close: @props.onClose
      show: "fade"
      open: @props.onOpen
      title: @props.title
      autoOpen: false
    @dialog = $(@node).dialog(options)
    @handlePropsChanged()
  componentWillUnmount: ->
    @dialog.destroy()
  render: ->
    R.div null
window.HandleDialog = HandleDialog
