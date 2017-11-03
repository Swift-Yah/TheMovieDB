//
//  Messageable.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/3/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

protocol Messageable: class {
    var messageGateway: MessageGateway { get set }
}
