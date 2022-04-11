module Styles = {
  open Css

  let buttonsArea = style(list{
    width(#percent(100.)),
    display(#flex),
    flexWrap(#wrap),
    justifyContent(#spaceAround),
    alignItems(#center),
    borderTop(#px(1), #solid, #hex(CommonStyles.defaultBorderHex)),
    paddingTop(#px(10)),
    marginTop(#px(10)),
  })
}

let helpText = `This is a piece of mildly interactive fiction about vampires, kink, and love. To proceed through the story, simply click your preferred dialogue option when presented with a choice.

CAUTION: this work contains many mentions of things that certain audiences might find upsetting. This includes BDSM, vampires, kidnapping, mind control, and probably other things I'm forgetting to mention. The tone of this work is comedic overall, and almost all depictions of sex and violence are meant to be funny rather than graphic, but please proceed at your own risk! You have been warned.

Ⓒ 2022 Andrea Zonghao Chen`

@react.component
let make = (~onClose: unit => unit) => {
  let _resetLocalStorage = React.useCallback0(_ => {
    Dom.Storage.clear(Dom.Storage.localStorage)
    Webapi.Dom.location->Webapi.Dom.Location.reloadWithForce
  })

  <Dialog onClose>
    <Text> helpText </Text>
    <div className=Styles.buttonsArea>
      <button onClick={_ => onClose()}> {React.string("Close")} </button>
    </div>
  </Dialog>
}
