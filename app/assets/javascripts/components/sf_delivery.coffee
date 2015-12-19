SfDelivery = React.createClass
  getInitialState: ->
    {
      content:
        how_it_works: "Our chef's menu of seasonally inspired meals arrives at your doorstep each Monday morning before 7am.\n" + "Our chef's curate, create, prep, and cook for you for that week. Never worry about the weekday dinner grind again!"
        free_delivery: "Lorem ipsum dolor sit amet, consectetuer."
        promo: "$10 credit to your next week's menu for each friend you refer. &nbsp;Have 364 friends?<br>Eat free for a year. &nbsp;</p>"
        feeding_america: "For every bag you leave out for reuse, Table Runner will donate $1 to Feeding America."
    }

  render: ->
    R.section
      id: "sf-delivery",
      R.div
        className: "container",
        R.div
          className: "title"
          R.img
            src: "/assets/TR_delivertoyourdoor.png"
        R.div
          className: "content",
          R.div
            className: "delivery-box"
            R.img
              alt: "Work 2"
              src: "/assets/shippingbox.png"
            R.h5 null, "NORTHERN CALIFORNIA"
            R.p
              className: "subtitle", "INSULATED BOX"
            R.p null, "Your meals will arrive chilled in an insulated box every Monday. Each box is carefully packed with gel packs to keep your meals fresh for the day in case you aren't at home. If you want to receive the box in person, check your email for tracking information."
          R.div
            className: "reusable-box"
            R.img
              alt: "Work 2"
              src: "/assets/bag_small.png"
            R.h5 null, "NORTHERN CALIFORNIA"
            R.p
              className: "subtitle", "INSULATED BOX"
            R.p null, "Your meals will arrive chilled in an insulated bag every Monday by 7am. Please leave last week's bag for our courier to pick up at the same time. "
            R.p null, "If you decide to keep a bag, we'll simply add a $10 charge to that week."
          R.div
            className: "delivery-map-1"
            R.img
              src: "/assets/sf_delivery.png"
          R.div
            className: "delivery-map-2"
            R.img
              src: "/assets/norcal.png"


window.SfDelivery = SfDelivery
