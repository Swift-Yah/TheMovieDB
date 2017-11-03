//
//  MessageGateway.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/3/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

protocol MessageGateway {
    func error(message: String)
    func hide()
    func hideAll()
    func info(message: String)
    func success(message: String)
    func warning(message: String)
}
