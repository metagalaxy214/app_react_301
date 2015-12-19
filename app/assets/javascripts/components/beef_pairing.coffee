BeefPairing = React.createClass
  getDefaultProps: ->
    close: ()->
  render: ->
    R.div
      id: "pairing-container"
      R.div
        id: "inner-container"
        R.div
          id: "menu-title"
          R.h2 null, "THYME ORANGE BRIASED NIMAN RANCH BEEF"
          R.h4 null, "with Carrots, Celery Root and Parsnips, Parsley New Potatoes, Horseradish Sour Cream"
          R.p null, "Colder weather and shorter days call for heartier dinners to warm the body and soul."
          
        R.div
          id: "ingredients"
          className: "pairing-div pairing-border"
          R.img
            className: "pairing-img"
            src: "/assets/NimanRanchLogo-web.png"
          R.div
            className: "pairing-title"
            R.h3 null, "NIMAN RANCH BEEF"
          R.div
            className: "pairing-text"
            R.p
              className: "pairing-paragraph", "To ﬁnd the best meats, we looked to Niman Ranch, a farm that began in the early 70’s on an eleven acre coastal town just North of San Francisco. Today, it’s a network of over 700 independent farmers and ranchers collecvely dedicated to strict protocols and the belief that all-natural, humanely raised, and sustainable methods produce the best possible ﬂavor.  Their beef is never given anbiocs or added hormones and is fed only the ﬁnest vegetarian feed"
        R.div
          id: "pairing"
          className: "pairing-div"
          R.img
            className: "pairing-img"
            src: "/assets/bogle.png"
          R.div
            className: "pairing-title"
            R.h3 null, "WINE PAIRING"
          R.div
            className: "pairing-text"
            R.p
              className: "wine-bold", "Bogle Old Vines Zinfandel 2012" 
            R.p
              className: "pairing-paragraph", "While Zinfandel these days don’t have the best reputation, this particular zin from Bogle comes from old vines that are 60-80 years old from Lodi, California.  Aged for two years in American oak, you’ll love how this wine pairs with the sweetness of the braised beef and carrots."
            R.p
              className: "wine-italic", "88 Points-Wine Spectator." 
  
window.BeefPairing = BeefPairing
