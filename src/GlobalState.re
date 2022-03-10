type action =
  | ScriptAdvanced
  | HelpDialogOpened
  | HelpDialogClosed
  | ChoiceSelected(int)
  | SpacePressed
  | EnterPressed
  | ArrowUpPressed
  | ArrowDownPressed;

type t = {
  script: list(Script.event),
  isShowingHelpDialog: bool,
  displayedNarration: array(Script.event),
  displayedChoices: option(array(Script.choice)),
  currentHighlightedChoiceIndex: option(int),
};

let textFadeInTime = 1000;

let rec reducer = (action: action, state: t): ReactUpdate.update(action, t) =>
  switch (action) {
  | ScriptAdvanced =>
    switch (state.script) {
    | [] => ReactUpdate.NoUpdate
    | [nextEvent, ...futureEvents] =>
      let state = {...state, script: futureEvents};
      switch (nextEvent) {
      | Choice(choices) =>
        ReactUpdate.Update({...state, displayedChoices: Some(choices)})
      | Narration(_)
      | Image(_) =>
        ReactUpdate.UpdateWithSideEffects(
          {
            ...state,
            displayedNarration:
              Belt.Array.concat(state.displayedNarration, [|nextEvent|]),
          },
          self => {
            self.send(ScriptAdvanced);
            None;
          },
        )
      };
    }
  | ChoiceSelected(index) =>
    let selectedChoice =
      Belt.Option.flatMap(state.displayedChoices, choices =>
        Belt.Array.get(choices, index)
      );

    switch (selectedChoice) {
    | Some({result, _}) =>
      ReactUpdate.UpdateWithSideEffects(
        {
          ...state,
          displayedChoices: None,
          currentHighlightedChoiceIndex: None,
          script: result,
        },
        self => {
          self.send(ScriptAdvanced);
          None;
        },
      )
    | None => ReactUpdate.NoUpdate
    };
  | HelpDialogOpened =>
    ReactUpdate.Update({...state, isShowingHelpDialog: true})
  | HelpDialogClosed =>
    ReactUpdate.Update({...state, isShowingHelpDialog: false})
  | ArrowUpPressed =>
    switch (state.displayedChoices) {
    | None => ReactUpdate.NoUpdate
    | Some(choices) =>
      switch (state.currentHighlightedChoiceIndex) {
      | Some(prevIndex) =>
        ReactUpdate.Update({
          ...state,
          currentHighlightedChoiceIndex:
            Some(
              (prevIndex + Belt.Array.length(choices) - 1)
              mod Belt.Array.length(choices),
            ),
        })
      | None =>
        ReactUpdate.Update({
          ...state,
          currentHighlightedChoiceIndex:
            Some(Belt.Array.length(choices) - 1),
        })
      }
    }
  | ArrowDownPressed =>
    switch (state.displayedChoices) {
    | None => ReactUpdate.NoUpdate
    | Some(choices) =>
      switch (state.currentHighlightedChoiceIndex) {
      | Some(prevIndex) =>
        ReactUpdate.Update({
          ...state,
          currentHighlightedChoiceIndex:
            Some((prevIndex + 1) mod Belt.Array.length(choices)),
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
      : (
        switch (state.displayedChoices, state.currentHighlightedChoiceIndex) {
        | (None, _)
        | (_, None) => reducer(ScriptAdvanced, state)
        | (Some(_choices), Some(highlightedIndex)) =>
          reducer(ChoiceSelected(highlightedIndex), state)
        }
      )
  | EnterPressed =>
    state.isShowingHelpDialog
      ? reducer(HelpDialogClosed, state)
      : (
        switch (state.displayedChoices, state.currentHighlightedChoiceIndex) {
        | (None, _)
        | (_, None) => reducer(ScriptAdvanced, state)
        | (Some(_choices), Some(highlightedIndex)) =>
          reducer(ChoiceSelected(highlightedIndex), state)
        }
      )
  };

let defaultState = {
  script: InitialScript.script,
  isShowingHelpDialog: false,
  displayedNarration: [||],
  displayedChoices: None,
  currentHighlightedChoiceIndex: None,
};
