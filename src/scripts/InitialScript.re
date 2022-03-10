open Script;

let choiceOneScript: list(Script.event) = [
  Narration({js|This is the first choice you made.|js}),
];
let choiceTwoScript: list(Script.event) = [
  Narration({js|This is the second choice you made.|js}),
];

let script: list(Script.event) = [
  Narration({js|This is the initially visible text.|js}),
  Choice([|
    {text: "Choice 1", result: choiceOneScript},
    {text: "Choice 2", result: choiceTwoScript},
  |]),
];
