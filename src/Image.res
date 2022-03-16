type t = Default

let imagesFolder = "assets/images/"

let getImage = image =>
  imagesFolder ++
  switch image {
  | Default => "default.png"
  }
