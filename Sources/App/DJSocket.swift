//
//  DJSocket.swift
//  HelloWorld
//
//  Created by Dejun Liu on 2016/12/11.
//
//

import Foundation
import SocksCore

protocol DJSocketDelegate {
    func sockDidDisconnect(sock: DJSocket)
    func sockDidRecviedData(data: [UInt8], sock: DJSocket)
}

public class DJSocket {
    var userId: String?
    var socket: TCPInternetSocket?
    var closed: Bool = false
    var delegate: DJSocketDelegate?
    
    init(sock: TCPInternetSocket) {
        self.socket = sock
    }
    
    func start() {
        while !self.closed {
            guard let data = try? self.socket!.recvAll() else {
                self.closed = true
                self.delegate?.sockDidDisconnect(sock: self)
                break
            }
            
            self.delegate?.sockDidRecviedData(data: data, sock: self)
        }
    }
    
    deinit {
        
    }
}
