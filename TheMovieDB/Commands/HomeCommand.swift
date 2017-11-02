//
//  HomeFeedback.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 11/01/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxSwift.Single

protocol HomeCommand {
	func execute() -> Single<StringResponse>
}
