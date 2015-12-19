CancelMembershipForm = React.createClass

  submit: (e)->
    e.preventDefault()

    @props.finished()

  render: ->
    R.section
      id: "cancel-membership",
      R.div
        className: "container",
        R.form
          action: "#"
          onSubmit: @submit,
          SectionTitle(text: "Cancel Membership")
          R.p null, "Cancellation will be effective immediately following the last completed delivery."
          R.p null, "Restart your membership anytime. We will save your preferences."
          R.p null, "A confirmation of your cancellation will be emailed to you."
          FieldRow fields: [
            {
              type: "submit"
              name: "cancel"
              value: @props.submit_value
            }
          ]

window.CancelMembershipForm = CancelMembershipForm
