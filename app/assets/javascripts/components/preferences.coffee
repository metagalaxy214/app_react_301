Preferences = React.createClass
  getInitialState: ->
    preferences:  []
  submit: (e)->
    e.preventDefault()
    temp_selected = []
    $('#checkbox-row input:checked').each ->
      temp_selected.push($(this).attr('value'))
    @props.preferences = temp_selected
    console.log @props.preferences
    @props.preferencesDone()

  changeSelected: (temp_selected)->
    new_state = @state
    new_state.selected = temp_selected
    @setState(new_state)

  componentDidMount: ->
    @_fetchPrefs({})
  _fetchPrefs: (data) ->
    $.ajax 
      url: "/preference"
      method: "GET"
      dataType: "json"
    .done @_fetchPrefsDone
    .fail @_fetchPrefsFail

  _fetchPrefsDone: (data, textStatus, jqXHR) ->
    @setState
      preferences: data

  _fetchPrefsFail: (xhr, status, err) => 
    console.error status, err.toString()

        
  render: ->
    R.div
      className: "container",
      R.img
        className: "section-title-image" 
        src: "/assets/preferences.png"
      R.p null,  "Please check any meats, fish, or shellfish you don't want us to cook with so that we personalize each menu to your preferences. Poultry, Beef and Pork are used by our chefs on a regular basis. You can always changes these settings in your account profile." 

      R.p null, "We do not unfortunately have any vegetarian meals at the moment but stay tuned."

      R.form
        action: "#"
        onSubmit: @submit,
        ref: "form"
        R.div
          className: "field-row"
          id: "checkbox-row"
          ref: "checks"
          for preference in @state.preferences
            R.label
              className: "checkbox after"
              R.input 
                type: "checkbox"
                value: "#{preference.id}"
              R.div
                className: "input"
                R.span null, "#{preference.name}"
        FieldRow fields: [
          {
            type: "submit"
            name: "submit"
            value: "Next"
          }
        ]

window.Preferences = Preferences
