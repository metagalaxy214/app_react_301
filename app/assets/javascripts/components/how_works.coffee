HowWorks = React.createClass
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
      id: "how-it-works",
      R.div
        className: "container",
        R.div
          className: "title"
          R.img
            src: "/assets/TR_howitworks.png"
        R.div
          className: "content",
          R.div
            className: "first-how"
            R.img
              alt: "Work 1"
              src: "/assets/TR_how-it-works-1.png"
            R.h5 null, "SIGN UP"
            R.p null, "You receive three chef-crafted meals (two-servings each). Each week promises new and exciting dishes. Skip any weeks you don't need. No minimums or hidden fees."


          R.div
            className: "second-how"
            R.img
              alt: "Work 2"
              src: "/assets/TR_how-it-works-2.png"
            R.h5 null, "SIT BACK AND RELAX"
            R.p null, "Each Week, our chefs shop for local farm-fresh produce which inspire that week's menu. And then they do all of the prepping and cooking for you. Meals are sealed and rushed fresh to your doorstep for free."
          R.div
            className: "third-how"
            R.img
              alt: "Work 3"
              src: "/assets/TR_how-it-works-3.png"
            R.h5 null, "ENJOY YOUR EVENING"
            R.p null, "You heat and artfully plate dinner in less time than it takes to order in. Cheers to more time enjoying the evening and to less time cooking and cleaning."

window.HowWorks = HowWorks
