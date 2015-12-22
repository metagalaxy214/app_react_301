ThankYouBox = React.createClass
  sendEmail: (e)->
    e.preventDefault()

    jQuery.ajax
      method: "POST"
      url: "/api/share_by_email"
      data:
        email: @refs.email_input.getDOMNode().value

      success: (response, status, xhr)->
        alert "Email successfully sent."

      failure: (xhr, status, response)->
        alert "Unable to send email. Try copying the code below and pasting it in an email."
  shareFacebook: (e)->
    e.preventDefault()

    fb = jQuery(@refs.facebook.getDOMNode())
    text = "https://members.tablerun.com/?referral_code=#{@props.referral_code}"

    @openShareLink "http://www.facebook.com/sharer/sharer.php?u=#{text}"

  shareTwitter: (e)->
    e.preventDefault()

    tw = jQuery(@refs.twitter.getDOMNode())
    text = "https://members.tablerun.com/?referral_code=#{@props.referral_code}"

    @openShareLink "https://twitter.com/intent/tweet?url=#{text}"

  openShareLink: (link)->
    win = window.open(link, "_blank")
    win.focus()

  render: ->
    R.div
      className: "container",
      R.img
        className: "section-title-image" 
        src: "/assets/thankyou.png"
      R.div
        className: "thank-you-text",

        R.div
          className: "refer-a-friend",
          "Refer a friend and get $10"
        R.div
          className: "credit",
          "Get $10 credit for every new friend you introduce to us."

        R.div
          className: "email-form",
          R.form
            onSubmit: @sendEmail
            R.input
              ref: "email_input"
              type: "email"
              placeholder: "Email"
              name: "email"
              required: "required"
            R.input
              type: "submit"
              value: "Send Email"
              readOnly: true
      R.div
        className: "referral",
        R.span null, "Or copy & paste your Personal Code"
        R.input
          name: "referral_code"
          type: "text"
          readOnly: true
          value: @props.referral_code

window.ThankYouBox = ThankYouBox
