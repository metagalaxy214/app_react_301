SubscriptionExplanation = React.createClass
  getInitialState: ->
    {
      content:
        how_it_works: "Our chef's menu of seasonally inspired meals arrives at your doorstep each Monday morning before 7am.\n" + "Our chef's curate, create, prep, and cook for you for that week. Never worry about the weekday dinner grind again!"
        free_delivery: "Lorem ipsum dolor sit amet, consectetuer."
        promo: "$10 credit to your next week's menu for each friend you refer. &nbsp;Have 364 friends?<br>Eat free for a year. &nbsp;</p>"
        feeding_america: "For every bag you leave out for reuse, Table Runner will donate $1 to Feeding America."
    }
  componentDidMount: ->
    jQuery.ajax
      method: "GET"
      url: "/api/contents/home-delivery"
      success: (response, status, jqxhr)=>
        new_state = @state
        new_state.content.how_it_works = response.how_it_works
        new_state.content.free_delivery = response.free_delivery
        new_state.content.promo = response.promo
        new_state.content.feeding_america = response.feeding_america
        @setState(new_state)
      error: (jqxhr, status, response)->
        alert jqxhr.responseJSON.error
  render: ->
    R.section
      id: "how-it-works",
      R.div
        className: "container",
        R.div className: "divider"
        R.div
          className: "content",
          R.h3
            className: "title",
            "How It Works"
          (R.p dangerouslySetInnerHTML: { __html: value }) for value in @state.content.how_it_works.split("\n")
          R.h3 null, "Free Delivery"
          (R.p dangerouslySetInnerHTML: { __html: value }) for value in @state.content.free_delivery.split("\n")
          R.h3 null, "Promo/Referral"
          (R.p dangerouslySetInnerHTML: { __html: value }) for value in @state.content.promo.split("\n")
          R.h3 null, "Feeding America"
          (R.p dangerouslySetInnerHTML: { __html: value }) for value in @state.content.feeding_america.split("\n")

window.SubscriptionExplanation = SubscriptionExplanation
