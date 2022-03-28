type rec event =
  | Narration(string)
  | FormattedNarration((~className: string) => React.element)
  | Choice(array<choice>)
  | Image(Image.t)
and choice = {
  text: string,
  result: list<event>,
}
