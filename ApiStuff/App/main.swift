import Vapor
import VaporMustache
import HTTP

let drop = Droplet()

drop.get("hello") { req in

  return "Hello, world!"

}

drop.get("helloJSON") { req in
  return try JSON([
      "message": "Hello, world!"
    ])
}

// users/<int>

drop.get("users", Int.self) { req, id in
  return try JSON([
      "user_id": id
    ])
}

drop.get("favorite") { req in
  guard let favoriteNumber = drop.config["app", "favorite-number"].string else{
    throw Abort.custom(status: .badRequest, message: "No Favorite Number found!")
  }
    return favoriteNumber
}

drop.serve()
