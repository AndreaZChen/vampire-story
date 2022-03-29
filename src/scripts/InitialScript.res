open Script

let rec script: list<Script.event> = list{
  Narration(`I awaken in a small, cold, brightly lit room, with a soft dizziness in my head and a slight cramp in one leg.

A single bare lightbulb hangs from the ceiling, illuminating what I take to be my new prison. My eyes adjust quickly, but there isn't much to see: the room is windowless, and seemingly devoid of furniture save for the chair I find myself strapped into. Beyond an open door, I can see a staircase leading upwards; I must be in a basement, then.

It takes an alarmingly long time for me to notice the woman standing in the corner. Why didn't I notice her immediately? Instinctively I try to move, but something around my wrists and ankles keeps me firmly secured. She laughs softly at my sudden flailing.

A somewhat troubling situation, then.`),
  Choice([
    {text: "Examine my restraints", result: examineRestraintsScript},
    {text: "Examine the woman", result: examineWomanScript},
  ]),
}
and examineRestraintsScript = list{
  Narration(`The restraints are, like, really bad.

Four leather straps have been hastily attached to the chair—a repurposed dental chair, I would guess—and wrapped around my wrists and ankles. But the work is shoddy, and I feel confident that I could easily escape given a few minutes of wriggling. I've been in worse, sexier situations before. This should not present a challenge.

The woman, on the other hand...`),
  Choice([{text: "Examine the woman", result: examineWomanScript}]),
}
and examineWomanScript = list{
  Narration(`She is tall, sickly pale, shaped like some sort of caricature of an anthropomorphized vulture. Her hair is long and black and needs to be brushed. Her fingers end in long, tapered claws, and her eyes burn with inhuman hunger. She is draped in flowing garments: a long, black dress and a blacker cloak wrapped around her, with glimpses of scarlet embroidery visible here and there.

All this to say, she's pretty hot.

"You are awake," she says. "Very good." Her voice is dark, deep, smooth, and she speaks with a curious accent I can't quite place.`),
  Choice([
    {text: "Who are you?", result: whoAreYouScript},
    {text: "Where am I?", result: whereAmIScript},
    {text: "What happened to my groceries?", result: myGroceriesScript},
  ]),
}
and whoAreYouScript = list{
  Narration(`"Who... who are you?" I ask. My voice is hoarse and weak.

A cartoonishly wide grin spreads across her face. "You don't know yet," she says. "But you will."

"... Yes?" I shake my head in bafflement, exacerbating my dizziness. "That's why I asked!"

This response seems to amuse her. She finally leaves the corner she's been lurking in and steps towards me, and I realize she is in fact quite tall. Really, very tall. She leans over me until her face partially obscures the lightbulb dangling above us, and places a cold, clawed hand against my cheek.

"Oh, my idiot darling," she says. "Already you are talking stupid."`),
}
and whereAmIScript = list{}
and myGroceriesScript = list{
  Narration(`"What... what happened to my groceries?" I ask. My voice is hoarse, but filled with conviction.

Her eyes narrow. "What do you mean?"

"My groceries"—I cough a little, feel my head spin—"you kidnapped me when I was grocery shopping. I remember. There was granola on special. I was walking home, and you... did something to me—"

"I hypnotize you, yes." She gives me a cold smile, baring two sharp fangs. "Your groceries... have been dealt with."

She finally leaves the corner she's been lurking in and steps towards me, and I realize she is in fact quite tall. Really, very tall. She leans over me until her face partially obscures the lightbulb dangling above us, and places a cold, clawed hand against my cheek.

"You will never see them again," she says.`),
  Choice([
    {text: "But really, what happened to my groceries?", result: reallyGroceriesScript},
    {text: "Why did you kidnap me?", result: whyKidnapScript},
  ]),
}
and reallyGroceriesScript = list{
  FormattedNarration(
    (~className) =>
      <p className>
        <span>
          {React.string(`"But really though, what happened to my stuff?" I say. "Did you just hypnotize me into dropping it all on the ground and walking away? I just don't like seeing food go to waste, is all."

She sighs and quickly draws her hand away from my face, scratching my skin. "If you `)}
        </span>
        <i> {React.string(`must`)} </i>
        <span> {React.string(` know," she hisses, "I `)} </span>
        <i> {React.string(`donate`)} </i>
        <span>
          {React.string(` your human food items." She averts her gaze for a moment, and I get the impression that she feels somewhat embarrassed. "I force you to give groceries to human woman with child. She take your granola."

"Oh," I say. "That was... surprisingly nice of you. Like, I am a little uncomfortable with doing it under mind control, but that's sort of sweet."

She smirks at me, and whatever momentary awkwardness had come over her seems to dissipate. "Yes, I knew you would like me," she says.`)}
        </span>
      </p>,
  ),
}
and whyKidnapScript = list{}
and showPhoneScript: list<Script.event> = list{
  Narration(`She pulls out her smartphone, spends some time struggling to unlock it with her claws, mutters under her breath. Then she flips it around and holds the screen up for me to see.

"This is how I found you!" she says excitedly. "It is good, yes?"

I lean forward, straining against the leather straps that keep me pinned to the chair, squinting. The screen is a little too far away for me to read it comfortably, and she doesn't hold the phone steady, but I can just barely make out the words. It's a webpage—an online store of some kind.`),
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
  Narration(`"It says for life," she says with a shrug. "Is pretty good deal."

"But what does this have to do with me?"

She taps her claw on the phone impatiently. "Read more! You will understand."`),
  FormattedNarration(
    (~className) =>
      <p className>
        <span> {React.string(`Very well. "`)} </span>
        <i> {React.string(`I have been conjuring spirits together since we were teenagers`)} </i>
        <span>
          {React.string(`," the text continues. "What does that even mean? It changed from first person singular to first person plural in like the same sentence."`)}
        </span>
      </p>,
  ),
  Narration(`"I did not know you would be grammar police," she snarls. Point taken.`),
  FormattedNarration(
    (~className) =>
      <p className>
        <span> {React.string(`"`)} </span>
        <i>
          {React.string(`We have a very high success rate with bringing keepers and spirits together. If you have taken in vampires in the past and have been disappointed you have just found the offering that will not disappoint. We will find you the perfect match in a vampire. After checkout is complete please email me with things you want your vampire to possess and his her race.`)}
        </i>
        <span>
          {React.string(`" I shake my head in disappointment. "Wow, okay. So first of all, vampire gender binary, and second of all, maybe a bit skeevy that they let you pick the ethnicity of your 'perfect match' vampire?"`)}
        </span>
      </p>,
  ),
  Narration(`She pulls the phone away and it disappears into her cloak somewhere. "I assure you," she says sweetly, "I did not specify particular race or gender for you. I am very open-minded vampire. I think you are very lovely specimen."

... Gears start turning in my head. My eyes narrow, and I give her a long, skeptical look. "You think I'm a vampire you bought online."

She nods.`),
  Choice([
    {text: "Tell her I'm not a vampire", result: notVampireScript},
    {text: "Ask why she bought a vampire on Etsy", result: whyEtsyScript},
  ]),
}
and notVampireScript = list{}
and whyEtsyScript = list{}
