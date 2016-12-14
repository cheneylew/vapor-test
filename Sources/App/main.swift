import Vapor
import Dispatch
import Foundation

// 游戏服务器
let server = DJServer()
server.run();

print("程序结束！~")

//let drop = Droplet()
//drop.get { req in
//    return try drop.view.make("welcome", [
//        "message": drop.localization[req.lang, "welcome", "title"]
//        ])
//}
//drop.get("/hello") { _ in
//    return "Hello Vapor"
//}
//drop.resource("posts", PostController())
//drop.run()
