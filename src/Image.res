type t = ShopPage

let imagesFolder = "assets/images/"

let getImage = image =>
  imagesFolder ++
  switch image {
  | ShopPage => "shop_page.jpg"
  }
