PairingBox = React.createClass
  render: ->
    R.div
      id: "pairing-container"
      R.div
        id: "inner-container"
        R.div
          id: "menu-title"
          R.h2 null, "CHICKEN PICCATA"
          R.h4 null, "with Creamy Parmesan Polenta and Ratatouille"
          R.p null, "Our deliciously healthy Mary's antibiotic free Chicken Piccata with zesty capers will leave your mouth and body smiling"
        R.div
          id: "ingredients"
          className: "pairing-div pairing-border"
          R.img
            className: "pairing-img"
            src: "/assets/redpepper-web.jpg"
          R.div
            className: "pairing-title"
            R.h3 null, "RED BELL PEPPERS"
          R.div
            className: "pairing-text"
            R.p
              className: "pairing-paragraph", "With a bright red shell guiding us to the beginning of the holiday season, sweet red bell peppers are a versatile fall vegetable that work well in salads and sweet stews. Here, our chefs use them in a ratatouille of fall favorites: eggplant, tomato, yellow squash, and zucchini. Our red bell peppers are packed with vitamin C and picked at peak ripeness to maximize the availability of vitamins and nutrients."
        R.div
          id: "pairing"
          className: "pairing-div"
          R.img
            className: "pairing-img"
            src: "/assets/oatley.png"
          R.div
            className: "pairing-title"
            R.h3 null, "WINE PAIRING"
          R.div
            className: "pairing-text"
            R.p
              className: "wine-bold", "Robert Oatley Signature Chardonnay 2013"
            R.p 
              className: "pairing-paragraph", "Fruity and smooth, this chardonnay is from Australia's most popular chardonnay region near the Margaret River. The peach, nectarine, and grapefruit flavors of the wine pair well with the nutty parmesan polenta and sweet peppers in the ratatouille."
  
window.PairingBox = PairingBox 
