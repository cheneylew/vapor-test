import Vapor
import Dispatch

//线程测试
var arr = [DispatchQueue]()

var count = 0
for i in 0...1000 {
    let queue =  DispatchQueue(label: "concurrentQueue\(count)", attributes: .concurrent)
    queue.async {
        count += 1;
        sleep(3000)
    }
    arr.append(queue)
}

print("共\(count)")

while true {
    
}
// 游戏服务器
//let server = DJServer()
//server.run();

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
