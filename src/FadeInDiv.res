module Styles = {
  open Css

  let fadeIn = startFadeInAtPercent =>
    keyframes(list{
      (0, list{opacity(0.)}),
      (startFadeInAtPercent, list{opacity(0.)}),
      (100, list{opacity(1.)}),
    })

  let wrapper = (fadeInTime, startFadeInAtPercent) =>
    style(list{animationName(fadeIn(startFadeInAtPercent)), animationDuration(fadeInTime)})
}

@react.component
let make = (
  ~children: React.element,
  ~className=?,
  ~fadeInTime=1000,
  ~startFadeInAt=0,
  ~onClick=?,
) => {
  let startFadeInAtPercent =
    startFadeInAt == 0
      ? 0
      : (float_of_int(startFadeInAt) /. float_of_int(fadeInTime) *. 100.)
        ->max(0.)
        ->min(100.)
        ->int_of_float

  let fadeInClassName = Styles.wrapper(fadeInTime, startFadeInAtPercent)
  let className = Belt.Option.mapWithDefault(className, fadeInClassName, someClass =>
    Css.merge(list{someClass, fadeInClassName})
  )
  <div className ?onClick> children </div>
}
