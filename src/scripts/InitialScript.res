open Script

let choiceOneScript: list<Script.event> = list{Narration(`This is the first choice you made.`)}
let choiceTwoScript: list<Script.event> = list{Narration(`This is the second choice you made.`)}

let rec script: list<Script.event> = list{
  Narration(`She pulls out her smartphone, spends some time struggling to unlock it with her claws, mutters under her breath. Then she flips it around and holds the screen up for me to see.

"This is how I found you!" she says excitedly. "It is good, yes?"

I lean forward, straining against the leather straps that keep me pinned to the chair, squinting. The screen is a little too far away for me to read it comfortably, and she doesn't hold the phone steady, but I can just barely make out the words. It's a webpage - an online store of some kind.`),
  Choice([{text: "Look closer", result: lookCloserScript}]),
}
and lookCloserScript: list<Script.event> = list{
  Image(ShopPage),
  FormattedNarration(
    (~className) =>
      <p className>
        <span> {React.string(`"`)} </span>
        <i> {React.string(`Custom Conjuring of Any Vampire Race You Desire`)} </i>
        <span> {React.string(`," I read out loud.`)} </span>
      </p>,
  ),
  Narration(`She nods solemnly. "Is expensive, but such powerful magic always comes at great cost."

"Yeah, it says here it costs $116.21," I continue. "But it's rated 5 stars by multiple people."

"Keep reading," she says, and (thankfully) moves the screen a little closer to me.`),
  FormattedNarration(
    (~className) =>
      <p className>
        <span> {React.string(`I oblige. "`)} </span>
        <i> {React.string(`Selling fast`)} </i>
        <span> {React.string(`," I read. "`)} </span>
        <i> {React.string(`Only 1 left, and 1 person has it in their basket`)} </i>
        <span> {React.string(`."`)} </span>
      </p>,
  ),
  Narration(`"You can skip this part," she hisses. A clawed finger quickly scrolls the page further down.`),
  FormattedNarration(
    (~className) =>
      <p className>
        <span> {React.string(`I keep reading. "`)} </span>
        <i>
          {React.string(`Today I offer a custom conjuring of any vampire race you desire. I will find you a vampire who is eager to serve and is full of life enhancing magick. You can choose your own vampire or let your vampire choose you. Either way I assure you a match will be made and a powerful vampire will be at your side ready to serve you for life.`)}
        </i>
        <span>
          {React.string(`" I give her an incredulous frown. "You paid actual money for this?"`)}
        </span>
      </p>,
  ),
  Choice([{text: "Keep reading", result: lookCloserScript}]),
}
