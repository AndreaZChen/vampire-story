open Script

let choiceOneScript: list<Script.event> = list{Narration(`This is the first choice you made.`)}
let choiceTwoScript: list<Script.event> = list{Narration(`This is the second choice you made.`)}

let script: list<Script.event> = list{
  Narration(`This is the initially visible text.`),
  Choice([
    {text: "Choice 1", result: choiceOneScript},
    {text: "Choice 2", result: choiceTwoScript},
  ]),
}
