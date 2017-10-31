//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import NSObject_Rx
import RxCocoa
import RxFeedback
import RxSwift
import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var topRatedButton: UIButton!
    @IBOutlet private weak var upcomingButton: UIButton!
    @IBOutlet private weak var configButton: UIButton!
    @IBOutlet private weak var detailButton: UIButton!
    @IBOutlet private weak var nowPlayingButton: UIButton!
    
    // MARK: UIViewController functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFeedback()
    }

    // MARK: Computed variables

    var binding: HomeFeedback.Feedback {
        return bind(self, { (controller, state) -> (Bindings<HomeEvent>) in
            let json = state.map({ $0.result })

            let subscriptions = [
                json.drive(controller.textView.rx.text)
            ]

            let events = [
                controller.popularButton.rx.tap.asSignal().map({ _ in HomeEvent.popularSelected }),
                controller.topRatedButton.rx.tap.asSignal().map({ _ in HomeEvent.topRatedSelected }),
                controller.upcomingButton.rx.tap.asSignal().map({ _ in HomeEvent.upcomingSelected }),
                controller.configButton.rx.tap.asSignal().map({ _ in HomeEvent.configSelected }),
                controller.detailButton.rx.tap.asSignal().map({ _ in HomeEvent.detailSelected }),
                controller.nowPlayingButton.rx.tap.asSignal().map({ _ in HomeEvent.nowPlayingSelected })
            ]

            return Bindings(subscriptions: subscriptions, events: events)
        })
    }
    
    // MARK: Private functions
    
    private func setupFeedback() {
        let movieService = MovieServiceableFactory.make()
        let requestJSON: (BaseTarget) -> Single<MovieListResponse> = { target in
            return movieService.request(token: target)
        }

        HomeFeedback
            .system(initialState: .empty, ui: binding, network: requestJSON)
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
