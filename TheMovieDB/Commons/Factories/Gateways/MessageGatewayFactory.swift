//
//  MessageGatewayFactory.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/3/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

struct MessageGatewayFactory {
    private init() { }
    
    static func make() -> MessageGateway {
        return SwiftMessagesGateway()
    }
}
