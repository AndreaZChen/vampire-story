module Styles = {
  open CssJs

  let fadeInTime = 1500

  let paddingAmount = 100

  let rootWrapper = style(. [
    overflowX(#hidden),
    overflowY(#auto),
    position(#absolute),
    display(#flex),
    alignItems(#center),
    justifyContent(#flexStart),
    flexDirection(#column),
    width(#percent(80.)),
    height(#calc(#sub, #percent(100.), #px(2 * paddingAmount))),
    top(#px(0)),
    left(#px(0)),
    paddingLeft(#percent(10.)),
    paddingRight(#percent(10.)),
    paddingTop(#px(paddingAmount)),
    paddingBottom(#px(paddingAmount)),
    backgroundColor(#hex(CommonStyles.defaultBackgroundHex)),
  ])

  let buttonArea = style(. [
    position(#fixed),
    display(#flex),
    zIndex(CommonStyles.dialogZIndex - 1),
    top(#px(5)),
    left(#px(5)),
  ])

  let narrationItemDiv = style(. [width(#percent(100.)), maxWidth(#px(740))])

  let imageItemDiv = style(. [maxWidth(#percent(75.)), maxHeight(#percent(75.))])

  let text = style(. [
    whiteSpace(#preWrap),
    width(#percent(100.)),
    marginTop(#pxFloat(15.75)),
    marginBottom(#pxFloat(15.75)),
  ])

  let image = style(. [maxWidth(#percent(100.)), maxHeight(#percent(100.))])

  let choicesDiv = style(. [display(#flex), flexWrap(#wrap)])

  global(.
    "body",
    [
      fontFamily(#custom("Georgia")),
      fontSize(#px(18)),
      lineHeight(#abs(1.75)),
      backgroundColor(#hex(CommonStyles.defaultBackgroundHex)),
    ],
  )
}

@react.component
let make = () => {
  let (globalState, globalDispatch) = ReactUpdate.useReducer(
    GlobalState.reducer,
    GlobalState.defaultState,
  )

  let rootDivRef = React.useRef(Js.Nullable.null)

  React.useEffect0(() => {
    globalDispatch(ScriptAdvanced)
    None
  })

  let adjustScroll = React.useCallback1(
    () =>
      rootDivRef.current
      ->Js.Nullable.toOption
      ->Belt.Option.mapWithDefault((), element => Webapi.Dom.Element.setScrollTop(element, 0.)),
    [rootDivRef],
  )

  let onCloseHelpDialog = React.useCallback1(
    () => globalDispatch(HelpDialogClosed),
    [globalDispatch],
  )

  let narrationElement = React.useMemo1(() =>
    Belt.Array.mapWithIndex(globalState.displayedNarration, (index, event) => {
      switch event {
      | Narration(text) =>
        <FadeInDiv
          className=Styles.narrationItemDiv fadeInTime=Styles.fadeInTime key={string_of_int(index)}>
          <p className=Styles.text> {React.string(text)} </p>
        </FadeInDiv>
      | FormattedNarration(element) =>
        <FadeInDiv
          className=Styles.narrationItemDiv fadeInTime=Styles.fadeInTime key={string_of_int(index)}>
          {element(~className=Styles.text)}
        </FadeInDiv>
      | Image(image) =>
        <FadeInDiv
          className=Styles.imageItemDiv fadeInTime=Styles.fadeInTime key={string_of_int(index)}>
          <img className=Styles.image src={Image.getImage(image)} />
        </FadeInDiv>
      | Choice(_) => React.null
      }
    })->React.array
  , [globalState.displayedNarration])

  <div className=Styles.rootWrapper ref={ReactDOM.Ref.domRef(rootDivRef)}>
    <div className=Styles.buttonArea> <HelpButton globalDispatch /> </div>
    {narrationElement}
    {switch globalState.displayedChoices {
    | Some(choices) =>
      <FadeInDiv fadeInTime=Styles.fadeInTime className=Styles.choicesDiv>
        {Belt.Array.mapWithIndex(choices, (index, choice) =>
          <button
            key={string_of_int(index)}
            onClick={_ => {
              adjustScroll()
              globalDispatch(ChoiceSelected(index))
            }}>
            {React.string(choice.text)}
          </button>
        )->React.array}
      </FadeInDiv>
    | None => React.null
    }}
    {globalState.isShowingHelpDialog ? <HelpDialog onClose=onCloseHelpDialog /> : React.null}
  </div>
}
