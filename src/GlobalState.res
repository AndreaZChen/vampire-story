type action =
  | ScriptAdvanced
  | HelpDialogOpened
  | HelpDialogClosed
  | ChoiceSelected(int)

type t = {
  script: list<Script.event>,
  isShowingHelpDialog: bool,
  displayedNarration: array<Script.event>,
  displayedChoices: option<array<Script.choice>>,
  currentHighlightedChoiceIndex: option<int>,
}

let reducer = (state: t, action: action): ReactUpdate.update<action, t> =>
  switch action {
  | ScriptAdvanced =>
    switch state.script {
    | list{} => ReactUpdate.NoUpdate
    | list{nextEvent, ...futureEvents} =>
      let state = {...state, script: futureEvents}
      switch nextEvent {
      | Choice(choices) => ReactUpdate.Update({...state, displayedChoices: Some(choices)})
      | Narration(_)
      | FormattedNarration(_)
      | Image(_) =>
        ReactUpdate.UpdateWithSideEffects(
          {
            ...state,
            displayedNarration: Belt.Array.concat(state.displayedNarration, [nextEvent]),
          },
          self => {
            self.send(ScriptAdvanced)
            None
          },
        )
      }
    }
  | ChoiceSelected(index) =>
    let selectedChoice = Belt.Option.flatMap(state.displayedChoices, choices =>
      Belt.Array.get(choices, index)
    )

    switch selectedChoice {
    | Some({result, _}) =>
      ReactUpdate.UpdateWithSideEffects(
        {
          ...state,
          displayedNarration: [],
          displayedChoices: None,
          currentHighlightedChoiceIndex: None,
          script: result,
        },
        self => {
          self.send(ScriptAdvanced)
          None
        },
      )
    | None => ReactUpdate.NoUpdate
    }
  | HelpDialogOpened => ReactUpdate.Update({...state, isShowingHelpDialog: true})
  | HelpDialogClosed => ReactUpdate.Update({...state, isShowingHelpDialog: false})
  }

let defaultState = {
  script: InitialScript.script,
  isShowingHelpDialog: false,
  displayedNarration: [],
  displayedChoices: None,
  currentHighlightedChoiceIndex: None,
}
