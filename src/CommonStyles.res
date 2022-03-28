open CssJs

let defaultBackgroundHex = "EEEEEE"
let darkerBackgroundHex = "d8d8d8"
let defaultBorderHex = "000000"
let defaultTextHex = "000000"
let defaultClickableTextHex = "B60024"
let defaultClickableHoveredTextHex = "DC143C"

let dialogZIndex = 1000

let mediaSizeLarge = "(min-width: 1281px)"
let mediaSizeMiddle = "(min-width: 824px) and (max-width: 1280px)"
let mediaSizeSmall = "(max-width: 823px)"

global(.
  "button",
  [
    margin(#px(10)),
    paddingTop(#em(0.35)),
    paddingBottom(#em(0.35)),
    paddingLeft(#em(1.2)),
    paddingRight(#em(1.2)),
    border(#em(0.1), #solid, #hex(defaultBorderHex)),
    backgroundColor(#hex(darkerBackgroundHex)),
    borderRadius(#em(0.12)),
    textAlign(#center),
    transitionDuration(200),
    not__(
      ":disabled",
      [
        cursor(#pointer),
        hover([backgroundColor(#hex(defaultBorderHex)), color(#hex(defaultBackgroundHex))]),
      ],
    ),
  ],
)
