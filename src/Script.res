type rec event =
  | Narration(string)
  | Choice(array<choice>)
  | Image(Image.t)
and choice = {
  text: string,
  result: list<event>,
}
