//
//  HomeViewController.swift
//  TheMovieDB
//
//  Created by Rafael Ferreira on 10/30/17.
//  Copyright © 2017 Swift Yah. All rights reserved.
//

import NSObject_Rx
import RxFeedback
import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var popularButton: UIButton!
    @IBOutlet private weak var topRatedButton: UIButton!
    @IBOutlet private weak var upcomingButton: UIButton!
    @IBOutlet private weak var configButton: UIButton!
    @IBOutlet private weak var detailButton: UIButton!
    @IBOutlet private weak var nowPlayingButton: UIButton!
    
    // MARK: Dependency Injection
    
    lazy var viewState: HomeState = {
        return HomeStateFactory.make()
    }()
    
    // MARK: UIViewController functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFeedback()
    }

    // MARK: Private Computed variables

    private var binding: HomeFeedback.Feedback {
        return bind(self, { (controller, state) -> Bindings<HomeEvent> in
            let subscriptions = [
                state.map({ $0.result }).drive(controller.textView.rx.text)
            ]

            let events = [
                controller.popularButton.rx.tap.asSignal().map({ HomeEvent.popularSelected }),
                controller.topRatedButton.rx.tap.asSignal().map({ HomeEvent.topRatedSelected }),
                controller.upcomingButton.rx.tap.asSignal().map({ HomeEvent.upcomingSelected }),
                controller.configButton.rx.tap.asSignal().map({ HomeEvent.configSelected }),
                controller.detailButton.rx.tap.asSignal().map({ HomeEvent.detailSelected(id: "211672") }),
                controller.nowPlayingButton.rx.tap.asSignal().map({ HomeEvent.nowPlayingSelected })
            ]

            return Bindings(subscriptions: subscriptions, events: events)
        })
    }
    
    // MARK: Private functions
    
    private func setupFeedback() {
        HomeFeedback.system(initialState: viewState, ui: binding).drive().disposed(by: rx.disposeBag)
    }
}
