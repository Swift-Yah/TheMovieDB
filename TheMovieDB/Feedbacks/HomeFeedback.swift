//
//  HomeFeedback.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct Foundation.URL
import struct RxSwift.Single
import struct RxCocoa.Signal
import struct RxCocoa.Driver
import RxFeedback
import Moya

struct HomeFeedback {
    typealias Feedback = (Driver<HomeState>) -> Signal<HomeEvent>

    static func system(initialState: HomeState,
                       ui: @escaping Feedback) -> Driver<HomeState> {
        let networkFeedback: Feedback = react(query: { $0.command }) { command -> Signal<HomeEvent> in
            return command.execute().map({ .success($0) })
                .asSignal(onErrorJustReturn: .failure(.offline))
                .map(HomeEvent.response)
        }

        return Driver<Any>.system(initialState: initialState, reduce: HomeState.reduce, feedback: ui, networkFeedback)
    }
}
