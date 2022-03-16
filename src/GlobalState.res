type action =
  | ScriptAdvanced
  | HelpDialogOpened
  | HelpDialogClosed
  | ChoiceSelected(int)
  | SpacePressed
  | EnterPressed
  | ArrowUpPressed
  | ArrowDownPressed

type t = {
  script: list<Script.event>,
  isShowingHelpDialog: bool,
  displayedNarration: array<Script.event>,
  displayedChoices: option<array<Script.choice>>,
  currentHighlightedChoiceIndex: option<int>,
}

let textFadeInTime = 1000

let rec reducer = (state: t, action: action): ReactUpdate.update<action, t> =>
  switch action {
  | ScriptAdvanced =>
    switch state.script {
    | list{} => ReactUpdate.NoUpdate
    | list{nextEvent, ...futureEvents} =>
      let state = {...state, script: futureEvents}
      switch nextEvent {
      | Choice(choices) => ReactUpdate.Update({...state, displayedChoices: Some(choices)})
      | Narration(_)
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
  | ArrowUpPressed =>
    switch state.displayedChoices {
    | None => ReactUpdate.NoUpdate
    | Some(choices) =>
      switch state.currentHighlightedChoiceIndex {
      | Some(prevIndex) =>
        ReactUpdate.Update({
          ...state,
          currentHighlightedChoiceIndex: Some(
            mod(prevIndex + Belt.Array.length(choices) - 1, Belt.Array.length(choices)),
          ),
        })
      | None =>
        ReactUpdate.Update({
          ...state,
          currentHighlightedChoiceIndex: Some(Belt.Array.length(choices) - 1),
        })
      }
    }
  | ArrowDownPressed =>
    switch state.displayedChoices {
    | None => ReactUpdate.NoUpdate
    | Some(choices) =>
      switch state.currentHighlightedChoiceIndex {
      | Some(prevIndex) =>
        ReactUpdate.Update({
          ...state,
          currentHighlightedChoiceIndex: Some(mod(prevIndex + 1, Belt.Array.length(choices))),
        })
      | None =>
        ReactUpdate.Update({
          ...state,
          currentHighlightedChoiceIndex: Some(0),
        })
      }
    }
  | SpacePressed =>
    state.isShowingHelpDialog
      ? ReactUpdate.NoUpdate
      : switch (state.displayedChoices, state.currentHighlightedChoiceIndex) {
        | (None, _)
        | (_, None) =>
          reducer(state, ScriptAdvanced)
        | (Some(_choices), Some(highlightedIndex)) =>
          reducer(state, ChoiceSelected(highlightedIndex))
        }
  | EnterPressed =>
    state.isShowingHelpDialog
      ? reducer(state, HelpDialogClosed)
      : switch (state.displayedChoices, state.currentHighlightedChoiceIndex) {
        | (None, _)
        | (_, None) =>
          reducer(state, ScriptAdvanced)
        | (Some(_choices), Some(highlightedIndex)) =>
          reducer(state, ChoiceSelected(highlightedIndex))
        }
  }

let defaultState = {
  script: InitialScript.script,
  isShowingHelpDialog: false,
  displayedNarration: [],
  displayedChoices: None,
  currentHighlightedChoiceIndex: None,
}
