//
//  DJServer.swift
//  HelloWorld
//
//  Created by Dejun Liu on 2016/12/11.
//
//

import Foundation
import SocksCore

public class DJServer: DJSocketDelegate {
    var server: TCPInternetSocket!
    var clients: [DJSocket] = []
    var taskQueue =  DispatchQueue(label: "com.queue.concurrent", attributes: .concurrent)
    
    public init() {
        let address = InternetAddress(hostname: "0.0.0.0", port: 8889)
        self.server = try! TCPInternetSocket(address: address)
    }
    
    public func run() {
        try! self.server.bind()
        try! self.server.listen(queueLimit: 10)
        print("服务器启动成功!")
        while true {
            guard let clientSock = try? self.server.accept() else {
                print("Accept 一个空的Socket")
                return;
            }
            print("进来了:\(clientSock.address.description)")
            let userSock = DJSocket(sock: clientSock)
            self.clients.append(userSock)
            
            userSock.delegate = self;
            userSock.start()
            
        }
    }

//MARK: - Socket Delegate
    func sockDidDisconnect(sock: DJSocket) {
        var idx = -1;
        for (k,v) in self.clients.enumerated() {
            if v.socket?.address == sock.socket?.address {
                idx = k
            }
        }
        
        if idx != -1 {
            print("离开了:\(sock.socket!.address.description)")
            self.clients.remove(at: idx)
            self.startThread()
        }
    }
    
    func sockDidRecviedData(data: [UInt8], sock: DJSocket) {
        let ocString = NSString(bytes: data, length: data.count, encoding: String.Encoding.utf8.rawValue)
        let string = String(describing: ocString)
        print(string)
    }
    
    func startThread() {
        //线程测试
        var threadCount = 0
        self.taskQueue.async(execute: {
            threadCount += 1;
            print("new thread start")
            for _ in 0...10000000 {
                var sum = 0
                for j in 0...100000 {
                    sum += j;
                }
            }
            print("new thread finished")
        })
    }
}

