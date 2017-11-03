//
//  HomeFeedback.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/31/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import struct RxCocoa.Driver
import struct RxCocoa.Signal
import RxFeedback

struct HomeFeedback {
    typealias Feedback = (Driver<HomeState>) -> Signal<HomeEvent>

    static func system(initialState: HomeState,
                       ui: @escaping Feedback) -> Driver<HomeState> {
        let networkFeedback: Feedback = react(query: { $0.command }) { command -> Signal<HomeEvent> in
            return command.execute()
                .asSignal(onErrorJustReturn: .failure(.offline))
                .map(HomeEvent.response)
        }

        return Driver<Any>.system(initialState: initialState, reduce: HomeState.reduce, feedback: ui, networkFeedback)
    }
}
