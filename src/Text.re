module Styles = {
  open Css;

  let text =
      (
        customColorHex: option(string),
        italicize: bool,
        bold: bool,
        displayValue,
      ) =>
    style([
      whiteSpace(`preWrap),
      fontStyle(italicize ? `italic : `normal),
      fontWeight(bold ? `bold : `normal),
      display(displayValue),
      color(
        `hex(
          Belt.Option.getWithDefault(
            customColorHex,
            CommonStyles.defaultTextHex,
          ),
        ),
      ),
    ]);
};

[@react.component]
let make =
    (
      ~customColorHex: option(string)=?,
      ~italicize=false,
      ~bold=false,
      ~display=`inline,
      ~children: string,
    ) =>
  <span className={Styles.text(customColorHex, italicize, bold, display)}>
    {React.string(children)}
  </span>;
