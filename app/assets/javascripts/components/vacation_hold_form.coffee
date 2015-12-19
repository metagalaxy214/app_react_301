VacationHoldForm = React.createClass

  fieldChanged: (field, new_value)->
    @props.infoChanged(field, new_value)

  submitHold: (e)->
    e.preventDefault()

    @props.finished()

  cancelHold: (e)->
    e.preventDefault()

    @props.cancel()

  render: ->
    R.section
      id: "vacation-hold",
      R.div
        className: "container",
        if @props.on_hold
          R.form
            action: "#"
            onSubmit: @submitHold,
            SectionTitle(text: "Vacation Hold")
            R.p null, "You currently have a Vacation Hold in place. You will need to cancel it manually to resume."
        else
          R.form
            action: "#"
            onSubmit: @submitHold,
            SectionTitle(text: "Vacation Hold")
            R.p null, "Going on vacation? We can suspend your delivery for two weeks."
            R.p null, "Deliveries will resume the first Monday after your return date."
            FieldRow fields: [
              {
                type: "radio"
                checked: "checked" if @props.vacation_hold == "one_week"
                name: "one_week"
                value: "vacation_hold"
                label_name: "One week hold"
              }
            ]
            FieldRow fields: [
              {
                type: "radio"
                checked: "checked" if @props.vacation_hold == "two_week"
                name: "two_week"
                value: "vacation_hold"
                label_name: "Two week hold"
              }
            ]
            FieldRow fields: [
              {
                type: "submit"
                name: "submit"
                value: @props.place_hold_submit_value
              }
            ]

        R.form
          action: "#"
          onSubmit: @cancelHold,
          R.p null, "If your plans change, you can cancel your Hold." unless @props.on_hold
          R.p null, "Deliveries will resume the first Monday after cancellation."
          if @props.on_hold
            FieldRow fields: [
              {
                type: "submit"
                name: "cancel"
                value: @props.cancel_hold_submit_value
              }
            ]

window.VacationHoldForm = VacationHoldForm
