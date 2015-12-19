RenewMembershipForm = React.createClass

  submit: (e)->
    e.preventDefault()

    @props.finished()

  render: ->
    R.section
      id: "renew-membership",
      R.div
        className: "container",
        R.form
          action: "#"
          onSubmit: @submit,
          SectionTitle(text: "Renew Membership")
          R.p null, "Restart your membership anytime. We've saved your preferences."
          R.p null, "A confirmation of your renewal will be emailed to you."
          FieldRow fields: [
            {
              type: "submit"
              name: "renew"
              value: @props.submit_value
            }
          ]

window.RenewMembershipForm = RenewMembershipForm
