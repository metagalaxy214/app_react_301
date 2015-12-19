PorkPairing = React.createClass
  render: ->
    R.div
      id: "pairing-container"
      R.div
        id: "inner-container"
        R.div
          id: "menu-title"
          R.h2 null, "ANCHO BRAISED PORK SHOULDER"
          R.h4 null, "with Cilantro Lime Rice Pilaf and Green and Yellow Squash and Tomatoes" 
          R.p null, "Adventure with the sweet and smokiness of free-range Hampshire antibiotic free pork shoulder briased with Ancho chiles"
        R.div
          id: "ingredients"
          className: "pairing-div pairing-border"
          R.img
            className: "pairing-img"
            src: "/assets/yellowsquash-web.jpg"
          R.div
            className: "pairing-title"
            R.h3 null, "YELLOW SQUASH"
          R.div
            className: "pairing-text"
            R.p
              className: "pairing-paragraph", "We are coming to the tail end of summer squash season and before we move into the winter squashes (think pumpkin and butternut), our chefs wanted to prepare a simple side of green and yellow squashes to celebrate the end of their season. We still may have a few weeks left and course can always ship them from warmer climates, but wanted to make sure we took advantage of some great local availability while we can."

        R.div
          id: "pairing"
          className: "pairing-div"
          R.img
            className: "pairing-img"
            src: "/assets/tablas.png"
          R.div
            className: "pairing-title"
            R.h3 null, "Wine Pairing"
          R.div
            className: "pairing-text"
            R.p
              className: "wine-bold", "Tablas Creek Patelin de Tablas Rouge 2011"
            R.p
              className: "pairing-paragraph", "We didn't have to go far to find a bright wine to pair with the smokey ancho chili braised pork. Located in Paso Robles, Tablas Creek Patelin de Tablas blends classic Rhone varietals grown and bottled locally in California. The finish is light and fruity to balance our smokey pork, yet spicy and complex enough to complement it's flavor."
            R.p
              className: "wine-italic", "91 Points-Wine Spectator."
    
window.PorkPairing = PorkPairing
